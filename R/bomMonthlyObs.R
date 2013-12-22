bomMonthlyObs <- function(siteNumber,observation="mean_max_temp",...) {

  if(class(observation)!="character") stop("observation must be; temp, rain or solar.")
  observation <- tolower(observation)
  if(is.na(match(observation,c("rain","mean_max_temp", "mean_min_temp", "highest_temp", "lowest_temp", "highest_min_temp","solar")))) stop("observation must be; mean_max_temp, mean_min_temp, highest_temp, lowest_temp, highest_min_temp, rain or solar.")
  
  #139 = rain, 36 = temp, 203 = solar
  # Some BOM sites start with a 0 (e.g 068166). If the R siteNumber is in numeric format, the 0 will be lost, so the for loop checks this and acts accordingly.
  if(is.numeric(siteNumber)){
    theurl <- paste("http://www.bom.gov.au/jsp/ncc/cdio/weatherData/av?p_nccObsCode=DATATYPE&p_display_type=dataFile&p_startYear=&p_c=&p_stn_num=0",siteNumber,sep="")
  } else {
    theurl <- paste("http://www.bom.gov.au/jsp/ncc/cdio/weatherData/av?p_nccObsCode=DATATYPE&p_display_type=dataFile&p_startYear=&p_c=&p_stn_num=",siteNumber,sep="")
  }
  if(observation=="rain") {
    theurl <- gsub("DATATYPE", "139",theurl)
    dataCode <- 139
  }
   # mean_max_temp, mean_min_temp, highest_temp, lowest_temp, highest_max_temp,highest_min_temp
  
  if(observation=="mean_max_temp") {
    theurl <- gsub("DATATYPE", "36",theurl)
    dataCode <- 36
  }
  if(observation=="mean_min_temp") {
    theurl <- gsub("DATATYPE", "38",theurl)
    dataCode <- 38
  }
  if(observation=="highest_temp") {
    theurl <- gsub("DATATYPE", "40",theurl)
    dataCode <- 40
  }
  if(observation=="lowest_temp") {
    theurl <- gsub("DATATYPE", "43",theurl)
    dataCode <- 43
  }
  if(observation=="lowest_max_temp") {
    theurl <- gsub("DATATYPE", "41",theurl)
    dataCode <- 41
  }
  if(observation=="highest_min_temp") {
    theurl <- gsub("DATATYPE", "42",theurl)
    dataCode <- 42
  }
  if(observation=="solar") {
    theurl <- gsub("DATATYPE", "203",theurl)
    dataCode <- 203
  }
  # make the orginal request to the server - this is needed to get a unique number from the server.
  # Gets the data from the webpage
  tables <- readHTMLTable(theurl,...)
  if(length(tables)==0){stop("Unfortunately there are no data available for the site number you have entered.
This may be because either the station number is invalid, or the station has
                             not observed the type of data requested.")
  }
  #removes unwanted rows. On the website the data is presented in groups of 25, so there are some odd rows here and there
  removeIndex <-tables[[1]][,1]=="Graph"|tables[[1]][,1]=="top"|tables[[1]][,1]=="Year"
  tables[[1]] <- tables[[1]][!removeIndex,]

# Some of the temp have placings -  need to check for them and remove them
	if(any(apply(tables[[1]][, -c(1,14)],2,function(x) grepl("th",x))==TRUE)){
		 characters <- nchar(as.character(tables[[1]][, -c(1,14)][,1]))
		 is_th <- grepl("th",as.character(tables[[1]][, -c(1,14)][,1]))
		 place_index <- rep(4,length(as.character(tables[[1]][, -c(1,14)][,1])))
		 place_index[!is_th&characters!=0] <- 3
	  	place_index[characters==0] <- 0
		obs <- as.numeric(substr(as.character(tables[[1]][, -c(1,14)][,1]),0,place_index))
		for(i in 2:12){
			  characters <- nchar(as.character(tables[[1]][, -c(1,14)][,i]))
			  is_th <- grepl("th",as.character(tables[[1]][, -c(1,14)][,i]))
			  place_index <- rep(4,length(as.character(tables[[1]][, -c(1,14)][,i])))
			  place_index[!is_th&characters!=0] <- 3
			  place_index[characters==0] <- 0
			  obs <- cbind(obs,as.numeric(substr(as.character(tables[[1]][, -c(1,14)][,i]),0,place_index)))
		}
		monthlyObs <- as.numeric(as.matrix(t(obs)))
	} else {
	  monthlyObs <- as.numeric(as.matrix(t(tables[[1]][, -c(1,14)])))
  }
  year <- rep(as.numeric(as.matrix(tables[[1]][, c(1)])),each=12)
  month <- rep(1:12, length=length(year))
  tables[[1]] <- data.frame(year, month, observation=monthlyObs)
  # Change the names of the two tables returned. The first table has the monthly data, and the second table has summary stats
  names(tables) <- c("monthly","summaryStats")
  return(tables)
}
