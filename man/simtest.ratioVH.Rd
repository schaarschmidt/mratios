\name{simtest.ratioVH}
\alias{simtest.ratioVH}

\title{Approximate simultaneous tests for ratios of normal means with heterogeneous variances}
\description{
  Performs simultaneous tests for several ratios of linear combinations of treatment means in a normal one-way layout,
 assuming normal distribution of the data allowing heterogeneous variances.
 
}
\usage{
simtest.ratioVH(formula, data,
 type = "Dunnett", base = 1, alternative = "two.sided",
 Margin.vec = NULL, FWER = 0.05,
 Num.Contrast = NULL, Den.Contrast = NULL,
 names = TRUE)
}

\arguments{
  \item{formula}{ A formula specifying a numerical response and a grouping factor (e.g., response ~ treatment) }
  \item{data}{  A dataframe containing the response and group variable }
  \item{type}{ type of contrast, with the following options:
  \itemize{
    \item{"Dunnett":}{ many-to-one comparisons, with control in the denominator}
    \item{"Tukey":}{ all-pair comparisons }
    \item{"Sequen":}{ comparison of consecutive groups, where the group with lower order is the denomniator}
    \item{"AVE":}{ comparison of each group with average of all others, where the average is taken as denominator}
    \item{"Changepoint":}{ ratio of averages of groups of higher order divided by averages of groups of lower order }
    \item{"Marcus":}{ Marcus contrasts as ratios }
    \item{"McDermott":}{ McDermott contrasts as ratios }
    \item{"Williams":}{ Williams contrasts as ratios }
    }
 Note: type is ignored if Num.Contrast and Den.Contrast are specified by the user (See below).
}
  \item{base}{ a single integer specifying the control (i.e. denominator) group for the Dunnett contrasts, ignored otherwise }
  \item{alternative}{ a character string:
    \itemize{
    \item{"two.sided":}{ for two-sided tests }
    \item{"less":}{ for lower tail tests }
    \item{"greater":}{ for upper tail tests }
}}
  \item{Margin.vec}{ a single numerical value or vector of Margins under the null hypotheses, default is 1 }
  \item{FWER}{ a single numeric value specifying the family-wise error rate to be controlled }
  \item{Num.Contrast}{ Numerator contrast matrix, where columns correspond to groups and rows correspond to contrasts  }
  \item{Den.Contrast}{ Denominator contrast matrix, where columns correspond to groups and rows correspond to contrasts }
  \item{names}{ a logical value: if TRUE, the output will be named according to names of user defined contrast or factor levels }
  
}

\details{
The associated ratio test statistic T[i] has a t-distribution. Multiplicity adjustment is achieved by using quantiles of r r-variate t-distributions, which differ in the degree of freedom and share the correlation structure. The compariso-specific degrees of freedom
are derived using the approximation according to Satterthwaite (1946).
}


\value{
  An object of class simtest.ratio containing:
  
  \item{estimate }{a (named) vector of estimated ratios}
  \item{teststat }{ a (named) vector of the calculated test statistics}
  \item{Num.Contrast }{the numerator contrast matrix}
  \item{Den.Contrast }{the denominator contrast matrix}
  \item{CorrMat }{the correlation matrix of the multivariate t-distribution calculated under the null hypotheses}
  \item{critical.pt }{the equicoordinate critical value of the multi-variate t-distribution for a specified FWER}
  \item{p.value.raw }{a (named) vector of unadjusted p-values}
  \item{p.value.adj }{a (named) vector of p-values adjusted for multiplicity}
  \item{Margin.vec }{the vector of margins under the null hypotheses}

and some other input arguments.

}

\references{

Simultaneous tests (adjusted p-values)

\emph{Hasler, M. and Hothorn, L.A. (2008):}
 Multiple contrast tests in the presence of heteroscedasticity.
 \emph{ Biometrical Journal 50, 793-800.}

Unadjusted tests (raw p-values)

\emph{Hasler M, Vonk R, Hothorn LA (2007).}
 Assessing non-inferiority of a new treatment in a three-arm trial in the presence of heteroscedasticity.
 \emph{ Statistics in Medicine 27, 490-503.}

\emph{Satterthwaite, FE (1946)}.
 An approximate distribution of estimates of variance components.
 \emph{Biometrics 2, 110-114}.
 }

\author{ Mario Hasler}

\seealso{ \link{sci.ratioVH} for corresponding confidence intervals }

\examples{

###############################################

data(Mutagenicity, package="mratios")

boxplot(MN~Treatment, data=Mutagenicity)

simtest.ratioVH(MN~Treatment, data=Mutagenicity,
 type="Dunnett", base=6, Margin.vec=1.2, alternative="less")


\dontrun{

###############################################

# Unadjusted confidence intervals for multiple ratios
# of means assuming heterogeneous group variances.
# The following code produces the results given in Table
# V of Hasler, Vonk and Hothorn (2007).
# The upper confidence limits in Table V can produced
# by calling:

# Mutagenicity of the doses of the new compound,
# expressed as ratio (DoseX-Vehicle)/(Cyclo25-Vehicle):

# Check the order of the factor levels:

levels(Mutagenicity$Treatment)

# numerators:

NC<-rbind(
"Hydro30-Vehicle"=c(0,0,1,0,0,-1),
"Hydro50-Vehicle"=c(0,0,0,1,0,-1),
"Hydro75-Vehicle"=c(0,0,0,0,1,-1),
"Hydro100-Vehicle"=c(0,1,0,0,0,-1)
)

DC<-rbind(
"Cyclo25-Vehicle"=c(1,0,0,0,0,-1),
"Cyclo25-Vehicle"=c(1,0,0,0,0,-1),
"Cyclo25-Vehicle"=c(1,0,0,0,0,-1),
"Cyclo25-Vehicle"=c(1,0,0,0,0,-1)
)

colnames(NC)<-colnames(DC)<-levels(Mutagenicity$Treatment)

NC

DC

# The raw p-values are those presented in Table V:

simtest.ratioVH(formula=MN~Treatment, data=Mutagenicity,
 Num.Contrast=NC, Den.Contrast=DC,
 alternative="less", Margin.vec=0.5, FWER=0.05)
}
}

\keyword{ htest }
\concept{ratio}
\concept{heteroscedasticity}
\concept{multiple comparisons}