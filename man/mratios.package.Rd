\name{mratios-package}
\alias{mratios-package}
\alias{mratios}
\docType{package}
\title{
mratios
}
\description{
 With this package, it is possible to perform (simultaneous) inferences for ratios of linear combinations of coefficients in the
          general linear model. In particular, tests and confidence interval estimations for ratios of
          treatment means in the normal one-way layout and confidence interval estimations like in (multiple) slope ratio
          and parallel line assays can be carried out. Moreover, it is possible to calculate the sample sizes required in comparisons
          with a control based on relative margins. For the simple two-sample problem, functions for a t-test for ratio-formatted
          hypotheses and Fieller confidence intervals are provided assuming homogeneous or
          heterogeneous group variances. 
}


\author{

Gemechis Dilba Djira, Mario Hasler, Daniel Gerhard, Frank Schaarschmidt

Maintainer: Frank Schaarschmidt <schaarschmidt@biostat.uni-hannover.de>

}
\references{

\emph{Dilba, G., Bretz, F., and Guiard, V. (2006).}
 Simultaneous confidence sets and confidence intervals for multiple ratios.
 \emph{Journal of Statistical Planning and Inference 136, 2640-2658.}

\emph{ Dilba, G., Bretz, F., Hothorn, L.A., and Guiard, V. (2006).}
 Power and sample size computations in simultaneous tests for non-inferiority based on relative margins.
\emph{ Statistics in Medicine 25, 1131-1147.}

\emph{Dilba, G., Guiard, V., and Bretz, F.}
 On the efficiency of ratio formatted hypotheses (submitted). 

\emph{Kieser, M. and Hauschke, D. (2000).}
 Statistical methods for demonstrating equivalence in crossover trials based on the ratio of two location parameters.
 \emph{Drug Information Journal 34, 563-568.}

\emph{Tamhane, A.C. and Logan, B.R. (2004).}
 Finding the maximum safe dose level for heteroscedastic data.
 \emph{Journal of Biopharmaceutical Statistics 14, 843-856.}

\emph{Hasler, M. and Hothorn, L.A. (2008).}
 Multiple contrast tests in the presence of heteroscedasticity.
 \emph{Biometrical Journal 50, 793-800.}

}
\keyword{ package }

\seealso{
Multiple comparisons for differences of means: \pkg{multcomp}
}

\examples{

library(mratios)

############################################################

# # # t.test.ratio: 
# Two-sample test and confidence interval
# for comparison of means, allowing for heteroscedasticity

data(ASAT)
ASAT
t.test.ratio(ASAT~group, data=ASAT, alternative="less", base=1,
 rho=1.25, var.equal=TRUE)

data(Mutagenicity)
boxplot(MN~Treatment, data=Mutagenicity)
# It seems to be inappropriate to assume homogeneous variances:

# 1) comparing whether the active control is more effective
# than vehicle control

t.test.ratio(MN~Treatment,
 data=subset(Mutagenicity, Treatment=="Cyclo25"|Treatment=="Vehicle"),
 alternative="greater", rho=1, var.equal=FALSE)

# 2) lowest dose vs. vehicle control

t.test.ratio(MN~Treatment,
 data=subset(Mutagenicity, Treatment=="Hydro30"|Treatment=="Vehicle"),
 alternative="greater", rho=1, var.equal=FALSE)


#########################################################

# # # sci.ratio:
# Calculation of simultaneous confidence intervals for ratios
# of linear combinations of treatment means in a one-way ANOVA model

data(BW)
boxplot(Weight~Dose, data=BW)

# Body weights of a 90-day chronic toxicology study on rats
# with a control (1) and three dose groups (2,3,4).

# Calculate upper confidence limits for the ratio of means
# of the three dose groups vs. the control group:
# Which of the doses lead to not more than 90 percent weight loss
# compared to the control group:

m21 <- sci.ratio(Weight~Dose, data=BW, type="Dunnett",
 alternative="greater")

summary(m21)

plot(m21, rho0=0.9)

###########################################################

# # # simtest.ratio: Simultaneous tests for ratios of means 


data(AP)

boxplot(prepost~treatment, data=AP)

# Test whether the differences of doses 50, 100, 150 vs. Placebo
# are non-inferior to the difference Active Control vs. Placebo 

NC <- rbind(
"(D100-D0)" = c(0,-1,1,0,0),
"(D150-D0)" = c(0,-1,0,1,0),
 "(D50-D0)" = c(0,-1,0,0,1))

DC <- rbind(
"(AC-D0)" = c(1,-1,0,0,0),
"(AC-D0)" = c(1,-1,0,0,0),
"(AC-D0)" = c(1,-1,0,0,0))

NC
DC

simtest.ratio(prepost ~ treatment, data=AP,
 Num.Contrast=NC, Den.Contrast=DC, Margin.vec=c(0.9,0.9,0.9))

summary( simtest.ratio(prepost ~ treatment, data=AP,
 Num.Contrast=NC, Den.Contrast=DC, Margin.vec=c(0.9,0.9,0.9)) )


#####################################################################

# # # sci.ratio.gen:
# Simultaneous confidence intervals for ratios of coefficients
# in the general linear model:

# Slope-ratio assay, data from Jensen(1989), Biometrical Journal 31,
# 841-853.

data(SRAssay)
SRAssay

# In this problem, the interest is in simultaneous estimation
# of the ratios of slopes relative to the slope of the standard
# treatment. 

# First it is needed to carefully define the vector of responses 
# and the design matrix of th general linear model:
# The design matrix can be constructed using model.matrix,
# and the vector of the response variable can be extracted
# from the dataframe.

X <- model.matrix(Response~Treatment:Dose, data=SRAssay)
Response <- SRAssay[,"Response"]

# The response vector and the design matrix are:

X
Response

# The following coefficients result:

lm(Response~0+X)

# where the last four coefficients are the estimated slopes
# of the control treatment and the three new treatments

# Contrasts for the ratios of the slopes of the three new treatments
# vs. the control are then defined as:

Num.Contrast <- matrix(c(0,0,1,0,0,
                         0,0,0,1,0,
                         0,0,0,0,1),nrow=3,byrow=TRUE)
Den.Contrast <- matrix(c(0,1,0,0,0,
                         0,1,0,0,0,
                         0,1,0,0,0),nrow=3,byrow=TRUE)


summary(sci.ratio.gen(Y=Response, X=X,
 Num.Contrast=Num.Contrast, Den.Contrast=Den.Contrast))

########################################################################

# # # n.ratio: Sample size computations in comparisons with a
#     control based on relative margins.


  #
  #  Example 1: Sample size calculation in tests for non-inferiority
  #  (two-sample case)(Laster and Johnson (2003),
  #  Statistics in Medicine 22:187-200)

     n.ratio(m=1, rho=0.8, Power=0.8, CV0=0.75, rho.star=1,
     alpha=0.05)


  #
  #  Example 2: Sample size calculation in simultaneous tests for
  #  non-inferiority
  #  (Dilba et al. (2006), Statistics in Medicine 25: 1131-1147)

     n.ratio(m=3, rho=0.7, Power=0.8, CV0=0.5, rho.star=0.95,
     alpha=0.05)

}
