\name{plot.sci.ratio}
\alias{plot.sci.ratio}

\title{ Plot output for sci.ratio and sci.ratio.gen }
\description{
  Plot the intervals returned by sci.ratio
}
\usage{
\method{plot}{sci.ratio}(x, rho0 = 1, rho0lty=2, rho0lwd=1, rho0col="black",
 CIvert = FALSE, CIlty = 1, CIlwd = 1, CIcex = 1, CIpch=16,
 main = NULL, ylab = NULL, xlab = NULL, sub = NULL, length=NULL,
 sortby=NULL, decreasing=NULL, ...)
}

\arguments{
  \item{x}{ an object of class "sci.ratio" as can be obtained by calling the function sci.ratio}
  \item{rho0}{ a single numeric value or vector of values defining the hypothesized ratio }
  \item{rho0lty}{ integer values to specify the line type for the rho0 line(s) }
  \item{rho0lwd}{ integer values to specify the line width for the rho0 line(s) }
  \item{rho0col}{ character vector to specify the colour for the rho0 line(s) }
  \item{CIvert}{ logical, CI are plotted horizontal if CIvert=FALSE and vertical otherwise }
  \item{CIlty}{ numeric value, giving the line type of the plotted confidence interval, see argument lty in ?par }
  \item{CIlwd}{ numeric value, giving the line width of the plotted confidence interval, see argument lwd in ?par }
  \item{CIcex}{ a single numeric value: by which amount the symbols in the CI shall be scaled relative to the default (see argument cex in ?par) }
  \item{CIpch}{ the symbol to be used for the point estimate, see pch in ?points}
  \item{main}{ character string to be plotted as main title of the plot }
  \item{ylab}{ character string, label of the y axis (ignored if CIvert=TRUE) }
  \item{xlab}{ character string, label of the x axis (ignored if CIvert=FALSE)  }
  \item{sub}{ as in plot }
  \item{length}{ a numeric value, specifying the length/2 of the bars at the ends of the confidence intervals in inches }
  \item{sortby}{ a character string, one of "estimate", "lower, or "upper"; if specified, the results are ordered by magnitude of estimates, lower or upper limits  }
  \item{decreasing}{ logical, to be passed to \code{order}, if \code{sortby} is specified, ignored otherwise }
  \item{\dots}{ further arguments to be passed to \code{axis()}}
 }

\details{
  Too long names of the contrasts/comparisons should be avoided, otherwise use par() to change plot parameters.
}
\value{
A plot of the confidence intervals in the sci.ratio object.
}
\references{ plot.hmtest(multcomp) }
\author{ Frank Schaarschmidt }
\examples{

library(mratios)

data(angina)

aCI<-sci.ratio(response~dose, data=angina, type="Dunnett",
 alternative="greater")

# Visualize testing for superiority

plot(aCI, rho0=1.25, rho0lty=3)



}
\keyword{ hplot }
\keyword{ htest }
