\name{bomMonthlyObs}
\alias{bomMonthlyObs}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
A BOM monthly observation getter.
}
\description{
A function to retrieve daily data from the BOM website.
}
\usage{
bomMonthlyObs(siteNumber, observation = "mean_max_temp",...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{siteNumber}{
Either numeric without leading 0, or character with leading 0 of the site number.
}
  \item{observation}{
The type of observation desired. Options are; observation must be; mean_max_temp, mean_min_temp, highest_temp, lowest_temp, highest_min_temp, rain or solar.
}
  \item{...}{
Additional commands for the RCurl package. 
}

}
\details{
The possible values are maximum monthly temp, solar exposure and rainfall. This function makes a request to the server and then reads the displayed values in two table
}
\value{
\item{monthly}{A data.frame containing the returned monthly values. }
\item{summaryStats}{A table of summary statistics for the site.}
}
\examples{
\dontrun{
siteNumber <- 066062
siteNumber
data <-bomMonthlyObs(siteNumber,observation="rain")
names(data)
names(data$monthly)
plot(data$monthly$observation,type="h")
data$summaryStats
}
}
