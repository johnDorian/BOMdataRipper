.onAttach <- function(lib, pkg) {
	pkg.info <- drop(read.dcf(file=system.file("DESCRIPTION", package="BOMdataRipper"),
                              fields=c("Title","Version","Date")))

	packageStartupMessage(paste("--------------------------------------------------------------\n",
				"For licesnsing terms of BOM data see:\n",
			   "http://www.bom.gov.au/other/copyright.shtml\n",
			 "--------------------------------------------------------------\n"
    )
    )
    	
}
# ### A function which checks how recently the site list has been downloaded and if older than 1 month downloads a new copy.
# .onLoad <- function(lib, pkg) {
#   data("last_updated")
#   diff_ <- as.numeric(difftime(now(),last_updated, units="days"))
#   if(diff_ > 30){
#     bomSites <- allBOMSites()
#     save(bomSites, file="data/site_list.RData")
#   }
# }
