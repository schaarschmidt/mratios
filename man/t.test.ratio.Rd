\name{t.test.ratio}
\alias{t.test.ratio}
\alias{t.test.ratio.default}
\alias{t.test.ratio.formula}


\title{ t-test for the ratio of two means }
\description{
Performs t-test for the ratio of means of two independent samples from two gaussian distributions.
In case of heterogeneous variances a Satterthwaite approximation of the degrees of freedom
is used (Tamhane & Logan, 2004).
}

\usage{
 
\method{t.test.ratio}{default}(x, y, alternative = "two.sided",
 rho = 1, var.equal = FALSE, conf.level = 0.95,
 iterativeCI=FALSE, ul=1e+10, ll=-1e+10, ...)
\method{t.test.ratio}{formula}(formula, data, base=2, ...)
}
\arguments{
  \item{x}{ A numeric vector (group in the numerator of the ratio) }
  \item{y}{ A numeric vector (group in the denominator of the ratio) }
  \item{formula}{ A two-sided formula specifying a numeric response variable and a factor with two levels }
  \item{data}{ A dataframe containing the variables specified in formula.
 Note: the first group in alpha-numeric order will appear in the denominator of the ratio}
  \item{alternative}{ character string defining the alternative hypothesis, one of "two.sided", "less" or "greater" }
  \item{rho}{ a single numeric value: the margin or ratio under the null hypothesis }
  \item{var.equal}{ logical, if set TRUE, a ratio-t-test assuming equal group variances is performed, otherwise (default) unequal variances are assumed }
  \item{conf.level}{ confidence level of Fieller's interval for the ratio of two means }
  \item{base}{if formula is used: a single numeric value specifying whether the first or second group (according to alpha-numeric order) is to be used as denominator}
  \item{iterativeCI}{a single logical, indicating whether the confidence limits shall be found with based on Fiellers formula (default) or by iteratively inverting the test (if TRUE); ignored when \kbd{var.equal=TRUE}}
  \item{ul}{a single numeric, defining the upper limit for searching the upper confidence bound in uniroot, if iterativeCI=TRUE and var.equal=FALSE, ignored otherwise}
  \item{ll}{a single numeric, defining the lower limit for searching the lower confidence bound in uniroot, if iterativeCI=TRUE and var.equal=FALSE, ignored otherwise}
  \item{\dots}{arguments to be passed to t.test.ratio.default}
}
\details{
This function implements the t-test for the ratio of two means and Fiellers confidence interval for the ratio of two means assuming mutually independent Gaussian errors with homogeneous variances, e.g. in Hauschke, Kieser, Hothorn (1999), when the argument \kbd{var.equal=TRUE}. With the argument \kbd{var.equal=FALSE} (default), the t-test for the ratio of two means assuming mutually independent Gaussian errors and possibly heterogeneous group variances (Tamhane and Logan, 2004) is implemented. When \kbd{iterativeCI = FALSE} (default) the corresponding confidence limits are obtained by using Fiellers formula with plug-in of the Satterthwaites degree of freedom calculated with the sample estimates for ratio and variances (not published). These bounds perform quite well but do not necessarily exactly coincide with the test decision. Setting \kbd{iterativeCI = TRUE} invokes interatively searching for the confidence limits by inverting Tamhane and Logans test using the function uniroot. If the confidence set is unbounded or gives irregular upper and/or lower bounds, a warning and NAs for the confidence limits are returned.

Note that when the mean of the denominator of the ratio is close to zero, confidence intervals might be degenerated and are not returned.

}
\value{
  An object of class "htest"
}
\references{ 

\emph{Hauschke, D., Kieser, M., Hothorn, L.A. (1999).}
 Proof of safety in toxicology based on the ratio of two means for normally distributed data.
\emph{Biometrical Journal 41, 295-304.}

\emph{Tamhane, A.C., Logan, B.R. (2004).}
 Finding the maximum safe dose level for heteroscedastic data.
 \emph{Journal of Biopharmaceutical Statistics 14, 843-856.}

 }
\author{ Frank Schaarschmidt }
\examples{

library(mratios)

####################################################

# ASAT values of female rats in a toxicity study
#     (Hauschke, 1999).

data(ASAT)
ASAT

t.test.ratio(ASAT~group, data=ASAT, alternative="less",
 base=1, rho=1.25, var.equal=TRUE)

######################################################

# Bodyweights of male rats in a toxicity study.
# Objective was to show equivalence between the high
# dose group (Dosis) and the control group (Kon).
# Equivalence margins are set to 0.8 and 1.25. The 
# type-I-error to show equivalence is set to alpha=0.05.

data(rat.weight)

# two one-sided tests:

t.test.ratio(weight~group, data=rat.weight, alternative="less",
 rho=1.25, var.equal=TRUE)

t.test.ratio(weight~group, data=rat.weight, alternative="greater",
 rho=0.8, var.equal=TRUE)



# For rho=1, t.test.ratio corresponds to a simple t.test
# with the difference of means under the null set to zero 
# (,i.e. mu=0).


t.test.ratio(ASAT~group, data=ASAT, alternative="less",
 rho=1, var.equal=TRUE)

t.test(ASAT~group, data=ASAT, alternative="less",
 mu=0, var.equal=TRUE)

# Ratio of means bewtween negative and positive control in the
# mutagenicity data set, allowing heterogeneous variances:

data(Mutagenicity)
DM<-subset(Mutagenicity, Treatment=="Vehicle"|Treatment=="Cyclo25")

# 95%-CI using the Fieller formula, Satterthwaite df with plug-in of 
# ratio estimate 

t.test.ratio(MN~Treatment, data=DM, alternative="two.sided",
 var.equal=FALSE, iterativeCI=FALSE)

# 95%-CI based on directly inverting Tamhane and Logans test 
# (Satterthwaite df, avoiding simple plug-in of the ratio estimate)

t.test.ratio(MN~Treatment, data=DM, alternative="two.sided",
 var.equal=FALSE, iterativeCI=TRUE)


}
\keyword{ htest }
\concept{ratio}
\concept{heteroscedasticity}