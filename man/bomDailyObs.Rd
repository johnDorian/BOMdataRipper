\name{bomDailyObs}
\alias{bomDailyObs}
\title{
A BOM daily observation getter.
}
\description{
A function to retrieve daily data from the BOM website.
}
\usage{
bomDailyObs(siteNumber, observation = "max_temp",...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{siteNumber}{
Either numeric without leading 0, or character with leading 0 of the site number.
}
  \item{observation}{
The type of observation desired. Options are; max_temp,min_temp, solar, rain.
}
  \item{...}{
Additional commands for the RCurl package. 
}


}
\details{
The possible values are maximum daily temp, solar exposure and rainfall. This function makes a request to the BOM website for the requested data. If the site and the type of data is available then a second request is made for a zip file of the data. The zip file is downloaded and unziped and loaded into R.
}
\value{
\item{}{A data.frame containing the returned values. }
}
\examples{
\dontrun{
siteNumber <- 066062
siteNumber
data <-bomDailyObs(siteNumber,observation="rain")
head(data)
siteNumber <- "066062"
data <-bomDailyObs(siteNumber,observation="solar")
head(data)

}
}
