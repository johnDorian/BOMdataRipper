allBOMSites <-
function(force_db_update=FALSE){
  if(!force_db_update){ ## if the user just wants teh results from the saved database then give them that. 
    days_since_last_update <- .check_age_of_database()
    if(days_since_last_update<30){
      data("site_list")
      return(bomSites)
    }
  }
  
  bomSites <- suppressWarnings(read.fwf (url("ftp://ftp.bom.gov.au/anon2/home/ncc/metadata/lists_by_element/alpha/alphaAUS_139.txt"),
                        widths=c(7,40,10,10,10,10,6,4,4),header=F,skip=3))
  names(bomSites) <- c("stationNumber","stationName","lat","long","startDate","endDate","years","coverage","stillActive")
  bomSites$coverage <- suppressWarnings(as.numeric(as.character(bomSites$coverage)))
  bomSites$stationNumber <- suppressWarnings(as.numeric(as.character(bomSites$stationNumber)))
  bomSites$lat <- suppressWarnings(as.numeric(as.character(bomSites$lat)))
  bomSites$long <- suppressWarnings(as.numeric(as.character(bomSites$long)))
  bomSites$startDate <- strptime(paste("1",bomSites$startDate),"%d %b %Y")
  bomSites$endDate <- strptime(paste("1",bomSites$endDate),"%d %b %Y")
  bomSites$stillActive <- suppressWarnings(as.character(bomSites$stillActive))
  bomSites$stillActive <- str_replace_all(bomSites$stillActive, " ", "")
  bomSites <- bomSites[-1,]
  bomSites <- head(bomSites, -6)
  save(bomSites, file="data/site_list.RData")
  last_updated <- now()
  save(last_updated, file="data/last_updated.RData")
  return(bomSites)
}

.check_age_of_database <- function(){
  data("last_updated")
  diff_ <- as.numeric(difftime(now(),last_updated, units="days"))
  return(diff_)
}
