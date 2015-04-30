\name{AP}
\alias{AP}
\docType{data}
\title{ Angina pectoris data}
\description{
  A data set is generated (from normal distribution) to imitate the summary statistics in Table II of Bauer et al. (1998). 
  In the experiment, patients with chronic stable angina pectoris were randomized to five treatment arms (placebo, three doses of a new compound, and an active control).
  The primary endpoint is the difference in the duration of an exercise test before and after treatment.
}
\usage{data(AP)}
\format{
  A data frame with 303 observations on the following 2 variables.
  \describe{
    \item{prepost}{a numeric vector, the difference post treatment measurement minus pre treatment measurement}
    \item{treatment}{a factor with levels AC (the active control), D0 (the zero dose, placebo), and D50, D100, D150, the three dose groups of the new compound.}
  }
}
\source{
\emph{Bauer, P., Roehmel, J., Maurer, W., and Hothorn, L. (1998).}
 Testing strategies in multi-dose experiments including active control.
\emph{ Statistics in Medicine 17, 2133-2146.}
}

\examples{

library(mratios)

data(AP)

str(AP)

boxplot(prepost ~ treatment, data=AP)
by(AP,AP$treatment, function(x){mean(x$prepost)})
by(AP,AP$treatment, function(x){sd(x$prepost)})

}
\keyword{datasets}
