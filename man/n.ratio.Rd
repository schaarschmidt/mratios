\name{n.ratio}
\alias{n.ratio}
\title{ Sample size computation in simultaneous tests for ratios of means }

\description{Computes the sample sizes required in simultaneous tests for non-inferiority (or superiority)
 based on relative margins in multiple comparisons with a control.  
  }
\usage{
n.ratio(m, rho, Power, CV0, rho.star, alpha, Min.power = TRUE)
}

\arguments{
  \item{m}{  number of comparisons with a control group }
  \item{rho}{ relative non-inferiority (or superiority) margin }
  \item{Power}{ given power (1-beta) }
  \item{CV0}{ coefficient of variation of the control group }
  \item{rho.star}{ the percentage (of the mean of the control group) to be detected }
  \item{alpha}{ familywise error rate }
  \item{Min.power}{ if set to TRUE (by default), the minimal power will be controlled,
 otherwise complete power }
}
\details{
The sample sizes are computed at the least favourable configurations, based on the assumption
 of no prior information regarding the true configuration of the ratios under the alternative
 hypotheses. The formula is

 \eqn{ n = ((C_1 + C_2)^2) (1 + \rho^2)/((\rho - \rho^*)^2) CV0^2 },
   
 where \eqn{C_1} is the lower \eqn{1-\alpha} equi-coordinate percentage point of an m-variate normal distribution 
 and \eqn{C_2} is the quantile of univariate (multivariate) normal distribution depending on the type of power 
 controlled. In tests for non-inferiority (or superiority) with large response values indicating better
 treatment benefit, \eqn{\rho < \rho^* }, where \eqn{\rho < 1} for non-inferiority and \eqn{\rho > 1} for superiority testing. 
 Whereas, if small response values indicate better treatment benefit, \eqn{\rho^* < \rho}, where \eqn{\rho > 1} for non-inferiority 
 and \eqn{\rho < 1} for superiority testing.                                                                                                  
}

\references{

\emph{ Dilba, G., Bretz, F., Hothorn, L.A., and Guiard, V. (2006).}
 Power and sample size computations in simultaneous tests for non-inferiority based on relative margins.
\emph{ Statistics in Medicine 25, 1131-1147.}
 }

\author{ Gemechis Dilba Djira }

\examples{


  #
  #  Example 1: Sample size calculation in tests for non-inferiority
  #  (two-sample case)(Laster and Johnson (2003),
  #  Statistics in Medicine 22:187-200)

     n.ratio(m=1, rho=0.8, Power=0.8, CV0=0.75, rho.star=1,
     alpha=0.05)


  #
  #  Example 2: Sample size calculation in simultaneous tests for
  #  non-inferiority
  #  (Dilba et al. (2006), Statistics in Medicine 25:1131-1147)

     n.ratio(m=3, rho=0.7, Power=0.8, CV0=0.5, rho.star=0.95,
     alpha=0.05)


  #
  #  Example 3: Controlling complete power
  #

     n.ratio(m=5, rho=1.2, Power=0.8, CV0=0.2, rho.star=1.40,
         alpha=0.05, Min.power=FALSE)

}
\keyword{ htest }
\concept{sample size}
\concept{power}