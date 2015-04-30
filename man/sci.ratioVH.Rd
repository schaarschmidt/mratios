\name{sci.ratioVH}
\alias{sci.ratioVH}

\title{ Approximate simultaneous confidence intervals for ratios of means when variances are heterogeneous }

\description{
  This function constructs simultaneous confidence intervals for ratios of linear combinations of normal means in a one-way model,
 allowing that the variances differ among groups. Different methods are available for multiplicity adjustment.
}

\usage{
sci.ratioVH(formula, data,
 type = "Dunnett", base = 1, method = "Plug",
 Num.Contrast = NULL, Den.Contrast = NULL,
 alternative = "two.sided", conf.level = 0.95,
 names = TRUE)
}


\arguments{
  \item{formula}{ A formula specifying a numerical response and a grouping factor as e.g. response ~ treatment }
  \item{data}{  A dataframe containing the response and group variable }
  \item{type}{ type of contrast, with the following options:
    \itemize{
    \item{"Dunnett":}{ many-to-one comparisons, with control in the denominator}
    \item{"Tukey":}{ all-pair comparisons }
    \item{"Sequen":}{ comparison of consecutive groups, where the group with lower order is the denominator}
    \item{"AVE":}{ comparison of each group with average of all others, where the average is taken as denominator}
    \item{"Changepoint":}{ ratio of averages of groups of higher order divided by averages of groups of lower order }
    \item{"Marcus":}{ Marcus contrasts as ratios }
    \item{"McDermott":}{ McDermott contrasts as ratios }
    \item{"Williams": }{Williams contrasts as ratios }
    }
 Note: type is ignored, if Num.Contrast and Den.Contrast are specified by the user (See below).}

  \item{base}{ a single integer specifying the control (i.e. denominator) group for the Dunnett contrasts, ignored otherwise }
  \item{method}{ 
    a character string, specifying the method to be used for confidence interval construction:
    \itemize{
    \item{"Plug":}{ Plug-in of ratio estimates to obtain the correlation matrix of contrasts (default)}
    \item{"Bonf":}{ Simple Bonferroni-adjustment of Fieller confidence intervals for the ratios }
    \item{"MtI":}{ Sidak- or Slepian- adjustment for two-sided and one-sided confidence intervals, respectively  }
    \item{"Unadj":}{ Unadjusted Fieller confidence intervals for the ratios (i.e. with comparisonwise confidence level = conf.level) }}
    }
  \item{Num.Contrast}{ Numerator contrast matrix, where columns correspond to groups and rows correspond to contrasts  }
  \item{Den.Contrast}{ Denominator contrast matrix, where columns correspond to groups and rows correspond to contrasts }
  \item{alternative}{ 
    a character string
    \itemize{
    \item{"two.sided":}{ for two-sided intervals }
    \item{"less":}{ for upper confidence limits }
    \item{"greater":}{ for lower confidence limits }}
    }
  \item{conf.level}{ simultaneous confidence level in case of method="Plug","Bonf", or "MtI", and comparisonwise confidence level in case of method="Unadj" }
  \item{names}{logical, indicating whether rownames of the contrast matrices shall be retained in the output}
}

\details{

Given a one-way ANOVA model, the interest is in simultaneous confidence intervals for several ratios of
linear combinations of the treatment means. It is assumed that the responses are normally distributed
with possibly heterogeneous variances. Multivariate t-distributions are applied with a correlation matrix
depending on the unknown ratios and sample variances and degress of freedom according to Satterthwaite
(1946).

Using \kbd{method="Unadj"} results in the methods described in Hasler, Vonk and Hothorn (2007).

}

\value{
  An object of class "sci.ratio", containing a list with elements:
  \item{estimate }{ the point estimates of the ratios}
  \item{CorrMat.est }{the estimated correlation matrix}
  \item{Num.Contrast }{matrix of contrasts used for the numerator of ratios}
  \item{Den.Contrast }{matrix of contrasts used for the denominator of ratios}
  \item{conf.int }{the estimated confidence intervals}
  \item{NSD }{a logical indicating whether any denominator occured, which were not significantly difference from 0}
and some of the input arguments.

}

\references{ 

Simultaneous confidence intervals:

\emph{Hasler, M. and Hothorn, L.A. (2008).}
 Multiple contrast tests in the presence of heteroscedasticity.
 \emph{ Biometrical Journal 50, 793-800.}

Marginal (unadjusted) confidence intervals:

\emph{Hasler M, Vonk R, Hothorn LA (2007).}
 Assessing non-inferiority of a new treatment in a three-arm trial in the presence of heteroscedasticity.
\emph{ Statistics in Medicine 27, 490-503.}

\emph{Satterthwaite, FE (1946).}
 An approximate distribution of estimates of variance components. 
\emph{Biometrics 2, 110-114.}

 }
\author{ Mario Hasler}

\seealso{ \link{plot.sci.ratio} for plots of confidence intervals and \link{simtest.ratioVH} for raw and multiplicity-adjusted p-values }
\examples{

data(Mutagenicity, package="mratios")

boxplot(MN~Treatment, data=Mutagenicity)

# Unless it is hard to assume Gaussian distribution
# in this example this is an attempt to take
# heterogeneous variances into account.

# Comparisons to the vehicle control,
# Proof of Hazard, using multiplicity adjusted 
# confidence intervals:

sci.ratioVH(MN~Treatment, data=Mutagenicity,
 type="Dunnett", base=6, method="Plug")

\dontrun{

# Unadjusted confidence intervals for an 
# intersection union test to proof safety
# for all doses of the compound.

sci.ratioVH(MN~Treatment, data=Mutagenicity,
 type="Dunnett", base=6, method="Unadj", alternative="less")


# # # # 

# User-defined contrasts:

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


CIs<-sci.ratioVH(MN~Treatment, data=Mutagenicity,
 Num.Contrast=NC,
 Den.Contrast=DC)

# # # #

# Unadjusted confidence intervals for multiple ratios
# of means assuming heterogeneous group variances.
# The following code produces the results given in Table
# V of Hasler, Vonk and Hothorn (2007).
# The upper confidence limits in Table V can produced
# by calling:

sci.ratioVH(formula=MN~Treatment, data=Mutagenicity,
 Num.Contrast=NC, Den.Contrast=DC,
 method="Unadj", alternative="less", conf.level=0.95)
}
}



\keyword{ htest }
\concept{ratio}
\concept{simultaneous confidence intervals}
\concept{heteroscedasticity}