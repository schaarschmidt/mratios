\name{summary.sci.ratio}
\alias{summary.sci.ratio}
\alias{summary.sci.ratio.gen}

\title{ Summary function for sci.ratio }
\description{
  Detailed print out for sci.ratio objects.
}
\usage{
\method{summary}{sci.ratio}(object, digits=4, ...)
}

\arguments{
  \item{object}{ an object of class "sci.ratio" or "sci.ratio.gen" as can be obtained by calling the function sci.ratio}
  \item{digits}{ digits for rounding the output }
  \item{\dots}{arguments to be passed to print}

}
\value{
A more detailed print output of the results and some computational steps used in sci.ratio. 
}

\seealso{ print.sci.ratio, plot.sci.ratio }


\examples{
data(BW)
RES <- sci.ratio(Weight~Dose, data=BW, type="Dunnett", alternative="greater")
summary(RES)
}

\keyword{ print }

