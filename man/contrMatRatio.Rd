\name{contrMatRatio}
\alias{contrMatRatio}

\title{ Creates numerator and denominator contrast matrices for ratio-based hypotheses for common multiple comparison and trend test problems }
\description{
 Creates numerator and denominator contrast matrices for some common multiple comparison and trend test problems. 
 These matrices are internally used by the sci.ratio and simtest.ratio functions. The contrMatRatio function is a modification of the function contrMat (multcomp).

 Whether the given definitions of contrast matrices for trend test problems in terms of ratios make sense and how they are to be interpreted is to be discussed.
}
\usage{
contrMatRatio(n, type = c("Tukey", "Dunnett", "Sequen", "AVE",
                 "GrandMean", "Changepoint", "Marcus", "McDermott",
                 "Williams", "UmbrellaWilliams"), base = 1)
}

\arguments{
  \item{n}{ integer vector of sample sizes }
  \item{type}{the type of multiple contrasts 
  \itemize{
    \item \bold{"Dunnett":} many to one comparisons, with the control group in the denominator

    \item \bold{"Tukey":} all-pair comparisons 

    \item \bold{"Sequen":} comparison of consecutive groups, where the groups of lower order is the denominator 

    \item \bold{"AVE":} comparison of each group with average of all others, where the average is taken as denominator

    \item \bold{"GrandMean":} comparison of each group with grand mean of all groups, where the grand mean is taken as denominator

    \item \bold{"Changepoint":} ratio of averages of groups of higher order divided by averages of groups of lower order 

    \item \bold{"Marcus":} Marcus contrasts defined for ratios 

    \item \bold{"McDermott":} McDermott contrasts for ratios 

    \item \bold{"Williams":} Williams contrasts for ratios 

    \item \bold{"UmbrellaWilliams":} Umbrella-protected Williams contrasts for ratios, i.e.a sequence of Williams-type contrasts with groups of higher order stepwise omitted 

    }
}
  \item{base}{a single integer specifying the control (i.e. denominator) group for "Dunnett"-type contrasts for calculating the ratios to the control }
}
\details{
  This is a simple adaption of the contrMat function in the package multcomp for ratio hypotheses.
}
\value{
  A list containing:
  \item{numC }{the (named) numerator contrast where rows correspond to contrasts } 
  \item{denC }{the (named) denominator contrast where rows correspond to contrasts }
  \item{rnames }{ a character vector with names of the contrasts }
  and the type of contrast as attr.

}

\author{ Frank Schaarschmidt and Daniel Gerhard by modifying the code of contrMat(multcomp) }
\seealso{ contrMat(multcomp) }
\examples{

library(mratios)

n=c(A=10,B=20,Z=10,D=10)

contrMatRatio(n=n, type="Dunnett", base=1)
contrMatRatio(n=n, type="Dunnett", base=3)

contrMatRatio(n=n, type="Tukey")
contrMatRatio(n=n, type="Sequen")
contrMatRatio(n=n, type="AVE")
contrMatRatio(n=n, type="GrandMean")
contrMatRatio(n=n, type="Williams")
contrMatRatio(n=n, type="UmbrellaWilliams")
}

\keyword{htest}
\concept{contrast}