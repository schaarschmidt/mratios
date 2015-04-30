\name{angina}
\alias{angina}
\docType{data}
\title{ The angina data set }
\description{
Dose response study of a drug to treat Angina pectoris. Response variable was the duration of pain-free walking after treatment, relative to the values before treatment. Large values indicate positive effects on patients. 
 Data set taken from Westfall et al. (1999), p. 164.
}
\usage{data(angina)}
\format{
  A data frame with 50 observations on the following 2 variables.
  \describe{
    \item{dose}{a factor with levels 0, 1, 2, 3, 4}
    \item{response}{a numeric vector giving the change from pretreatment as measured
          in minutes of pain-free walking.}
  }
}
\details{
  See Westfall et al. (1999, p. 164)
}
\source{
   P. H. Westfall, R. D. Tobias, D. Rom, R. D. Wolfinger, Y. Hochberg
     (1999). Multiple Comparisons and Multiple Tests Using the SAS
     System. Cary, NC: SAS Institute Inc.
}
\references{
  angina(multcomp)
}
\examples{

library(mratios)

data(angina)

str(angina)

plot(response~dose, data=angina)

}
\keyword{datasets}
\concept{dose response}
