allBOMSites <-
function(force_db_update=FALSE){
  if(!force_db_update){ ## if the user just wants teh results from the saved database then give them that. 
    days_since_last_update <- .check_age_of_database()
    if(days_since_last_update<30){
      site_numbers <- dir("data/", pattern="site_list_")
      load(paste0("data/", site_numbers))
      return(bomSites)
    }
  }
  
  bomSites <- suppressWarnings(read.fwf (url("ftp://ftp.bom.gov.au/anon2/home/ncc/metadata/lists_by_element/alpha/alphaAUS_139.txt"),
                        widths=c(7,40,10,10,10,10,6,4,2),header=F,skip=3))
  names(bomSites) <- c("stationNumber","stationName","lat","long","startDate","endDate","years","coverage","stillActive")
  bomSites$lat <- suppressWarnings(as.numeric(as.character(bomSites$lat)))
  bomSites$startDate <- strptime(paste("1",bomSites$startDate),"%d %b %Y")
  bomSites$endDate <- strptime(paste("1",bomSites$endDate),"%d %b %Y")
  bomSites <- bomSites[-1,]
  bomSites <- head(bomSites, -6)
  save(bomSites, file=paste0("data/site_list_", format(today(), "%Y_%m_%d"), ".Rdata"))
  return(bomSites)
}

.check_age_of_database <- function(){
  site_numbers <- dir("data/", pattern="site_list_")
  file_string <- str_split(site_numbers, "list_")
  date_string <- str_replace(file_string[[1]][2], ".Rdata", "")
  last_updated <- ymd(date_string)
  diff_ <- as.numeric(difftime(now(),last_updated, units="days"))
  return(diff_)
}
