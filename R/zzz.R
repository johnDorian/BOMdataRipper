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
