\name{print.sci.ratio}
\alias{print.sci.ratio}

\title{ Print function for sci.ratio objects }
\description{
  A short print out of the value of a sci.ratio object.
}
\usage{
\method{print}{sci.ratio}(x, digits=4,...)
}
\arguments{
  \item{x}{ an object of class "sci.ratio" as can be obtained by calling the function sci.ratio}
  \item{digits}{ digits for rounding the output}
  \item{\dots}{arguments to be passed to print}

}

\value{
  A print out of the confidence intervals computed by sci.ratio.
}

\seealso{ \link{plot.sci.ratio}, \link{summary.sci.ratio} }


\keyword{ print }