\name{BW}
\alias{BW}
\docType{data}
\title{ Body weights measured in a toxicological study}
\description{
  Body weights of a 90-day chronic toxicological study on rats with a control and three dose groups.
}
\usage{data(BW)}
\format{
  A data frame with 60 observations on the following 2 variables.
  \describe{
    \item{Weight}{a numeric vector containing the bodyweights of rats}
    \item{Dose}{a factor with levels 1, 2, 3, 4, specifying the dose groups, where 1 is the control group }
  }
}
\source{
\emph{Hothorn, L.A. (2004):}
 Statistische Auswerteverfahren. In: \emph{Regulatorische Toxikologie (Reichl, F.X., ed.).} Springer Verlag Heidelberg, pp. 167-181.
}

\examples{

library(mratios)

data(BW)

str(BW)

boxplot(Weight~Dose, data=BW)


}
\keyword{datasets}
