\name{allBOMSites}
\alias{allBOMSites}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Retrieve all BOM sites in Australia
}
\description{
A wrapper function to download a list of all BOM sites.
}
\usage{
allBOMSites()
}

\value{
\item{}{A data.frame with the following; station number, station name, lat, long, start date, end date, years, still active}
}

\examples{
\dontrun{
  sites<-allBOMSites()
  head(sites)
}
}