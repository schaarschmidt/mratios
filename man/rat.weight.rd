\name{rat.weight}
\alias{rat.weight}
\docType{data}
\title{ Body weight of rats in a toxicity study }
\description{Body weights of male rats were compared between a control group and a group which had received a high dose of a chemical in a toxicity study after a period of recovery
  }
\usage{data(rat.weight)}
\format{
  A data frame with 20 observations on the following 2 variables.
  \describe{
    \item{group}{a factor with two levels, Dosis and Kon, where Dosis is the high dose group, consisiting of ten individulas and Kon is the control group, consisting of ten individuals}
    \item{weight}{a numeric vector containing the values of response variable, final body weight in gramm}
  }
}
\details{
 Aim was to test that application of the chemical does not lead to a relevantly lowered or heightened body weight after a time of recovery. 0.8 and 1.25 were defined as relevance boundaries compared to the mean of control group }

\source{
\emph{Hauschke, D. (1999).}
 Biometrische Methoden zur Auswertung und Planung von Sicherheitsstudien.
 \emph{Habilitationsschrift, Fachbereich Statistik, Universtaet Dortmund.}
}

\examples{

library(mratios)

data(rat.weight)
boxplot(weight~group, data=rat.weight)

}
\keyword{datasets}