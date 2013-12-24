.onAttach <- function(lib, pkg) {
	pkg.info <- drop(read.dcf(file=system.file("DESCRIPTION", package="BOMdataRipper"),
                              fields=c("Title","Version","Date")))

	packageStartupMessage(paste("--------------------------------------------------------------\n",
				"\bThis package contains NO data. For licesnsing terms of BOM\ndata see:",
			   "http://www.bom.gov.au/other/copyright.shtml\n",
			 "--------------------------------------------------------------\n"
    )
    )
    	
}
### A function which checks how recently the site list has been downloaded and if older than 1 month downloads a new copy.
.onLoad <- function(lib, pkg) {
  diff_ <- check_age_of_database()
  if(diff_ > 30){
    bomSites <- allBOMSites()
    save(bomSites, file=paste0("data/site_list_", format(today(), "%Y_%m_%d"), ".Rdata"))
  }
}
