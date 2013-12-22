allBOMSites <-
function(){
  bomSites <- suppressWarnings(read.fwf (url("ftp://ftp.bom.gov.au/anon2/home/ncc/metadata/lists_by_element/alpha/alphaAUS_139.txt"),
                        widths=c(7,40,10,10,10,10,6,4,2),header=F,skip=3))
  names(bomSites) <- c("stationNumber","stationName","lat","long","startDate","endDate","years","coverage","stillActive")
  bomSites$lat <- suppressWarnings(as.numeric(as.character(bomSites$lat)))
  bomSites$startDate <- strptime(paste("1",bomSites$startDate),"%d %b %Y")
  bomSites$endDate <- strptime(paste("1",bomSites$endDate),"%d %b %Y")
  return(bomSites)
}
