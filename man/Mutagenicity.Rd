\name{Mutagenicity}
\alias{Mutagenicity}
\docType{data}
\title{ Mutagenicity assay }
\description{
  Mutagenicity assay for 4 doses of a compound (hydroquinone) against a negative (vehicle) control and a positive (active) control (cyclophosphamide). 
  Hydroquinone was applied in doses of 30, 50, 70, 100 mg/kg, positive control was applied with 25mg/kg.
  Counts of micronuclei in polychromatic erythrocytes after 24h are taken as a measure for the potency to induce chromosome damage. Data of male mice are presented
 (Hauschke et al., 2005).
}
\usage{data(Mutagenicity)}
\format{
  A data frame with 31 observations on the following 2 variables.
  \describe{
    \item{Treatment}{a factor with levels Cyclo25, Hydro100, Hydro30, Hydro50, Hydro75, Vehicle}
    \item{MN}{a numeric vector, giving the counts of micronuclei after 24h}
  }
}

\source{
 \emph{Adler, ID, and Kliesch, U (1990).}
 Comparison of single and multiple treatment regiments in the mouse bone marrow micronucleus assay for hydroquinone and cyclophosphamide.
 \emph{Mutation Research 234, 115-123.}
}
\references{
\emph{Hauschke, D, Slacik-Erben, R, Hansen, S, Kaufmann,R (2005).}
 Biostatistical Assessment of mutagenicity studies by including the positive control.
 \emph{Biometrical Journal 47, 82-87.}
}
\examples{

data(Mutagenicity)

str(Mutagenicity)

boxplot(MN~Treatment, data=Mutagenicity)

}
\keyword{datasets}
