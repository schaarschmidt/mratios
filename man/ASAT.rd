\name{ASAT}
\alias{ASAT}
\docType{data}
\title{ ASAT data }
\description{Data from a toxicity study: ASAT values of the serum of female Wistar rats six months after application }
\usage{data(ASAT)}
\format{
  A data frame with 34 observations on the following 2 variables.
  \describe{
    \item{group}{a factor with two levels KON, and TREAT, where KON is the control group consisting of 19 subjects and TREAT is the treatment group consisting of only 15 subjects due to mortality }
    \item{ASAT}{a numeric vector containing values of the response variable}
  }
}
\details{The objective is to test that ASAT values of treatment group are not relevantly heightened compared to the control group,
where average ASAT value which is more than 25 percent higher than the average of the control group is defined as relevant.
 }
\source{
\emph{Hauschke, D. (1999).}
 Biometrische Methoden zur Auswertung und Planung von Sicherheitsstudien.
\emph{ Habilitationsschrift, Fachbereich Statistik, Universtaet Dortmund.}
}

\examples{

library(mratios)

data(ASAT)

str(ASAT)
boxplot(ASAT~group, data=ASAT)

}
\keyword{datasets}
