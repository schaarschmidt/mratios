\name{sci.ratio.gen}
\alias{sci.ratio.gen}

\title{ Simultaneous confidence intervals for ratios of coefficients in the general linear model }
\description{
Constructs simultaneous confidence intervals for multiple ratios of linear combinations of coefficients in the general linear model.
}
\usage{
sci.ratio.gen(Y, X, Num.Contrast, Den.Contrast,
 alternative = "two.sided", conf.level = 0.95,
 method="Plug")
}

\arguments{
  \item{Y}{ A numerical vector, containing the values of the response variable }
  \item{X}{ A design matrix for the the linear model, defining the parameters to be estimated, must have same number of rows as Y }
  \item{Num.Contrast}{ Numerator contrast matrix }
  \item{Den.Contrast}{ Denominator contrast matrix }
  \item{alternative}{ one of "two.sided", "less", or "greater" }
  \item{conf.level}{ simultaneous confidence levels }
  \item{method}{ 
    character string, specifying the method for confidence interval calculation:
  \itemize{
    \item \bold{"Plug":} Plug-in of ratio estimates in the correlation matrix of the multivariate t distribution. This method is the default.
    \item \bold{"Bonf":} Simple Bonferroni-adjustment of Fieller confidence intervals for the ratios 
    \item \bold{"MtI":} Sidak or Slepian- adjustment for two-sided and one-sided confidence intervals, respectively  
    \item \bold{"Unadj":} Unadjusted Fieller confidence intervals for the ratios (i.e. with comparisonwise confidence level = conf.level) 
    }
  }
}
\details{

Given a general linear model, the interest is in simultaneous confidence intervals
for several ratios of linear combinations of the coefficients in the model. It is assumed that the
responses are normally distributed with homogeneous variances. In this problem, the joint distribution
of the likelihood ratio statistics has a multivariate t-distribution
the correlation matrix of which depends on the unknown ratios. This means that the critical
point needed for CI calculations also depends on the ratios. There are various methods
of dealing with this problem (for example, see Dilba et al., 2006). The methods include (i) the unadjusted
intervals (Fieller confidence intervals without multiplicity adjustments), (ii) Bonferroni (Fieller
intervals with simple Bonferroni adjustments), (iii) MtI (a method based on Sidak and Slepian
inequalities for two- and one-sided confidence intervals, respectively), and (iv) plug-in (plugging
the maximum likelihood estimates of the ratios in the unknown correlation matrix). The MtI method consists
of replacing the unknown correlation matrix by an identity matrix of the same dimension.

Applications include relative potency estimations in multiple parallel line or slope-ratio assays.
Users need to define the design matrix of the linear model and the corresponding contrast matrices 
in an appropriate way.

}
\value{
  A list containing 
  
  \item{estimate}{point estimates for the ratios}
  \item{CorrMat.est}{estimates of the correlation matrix (for the plug-in approach)}
  \item{Num.Contrast}{matrix of contrasts used for the numerator of ratios}
  \item{Den.Contrast}{matrix of contrasts used for the denominator of ratios}
  \item{conf.int}{confidence interval estimates of the ratios}
  \item{Y }{response vector }
  \item{X }{design matrix}
  \item{fit }{ the model fit, an object of class "lm"}
and some further input arguments, to be passed to print and summary functions.   

}
\references{
 \emph{Dilba, G., Bretz, F., and Guiard, V. (2006).}
 Simultaneous confidence sets and confidence intervals for multiple ratios.
 \emph{Journal of Statistical Planning and Inference 136, 2640-2658.}
 }
\author{ Gemechis Dilba Djira }

\seealso{ glht(multcomp) for multiple comparisons of parameters from lm, glm,...,
\link{sci.ratio} for confidence intervals for ratios of means in a one-way-layout,
\link{simtest.ratio} for simultaneous tests for ratios of means in a one-way-layout,
\link{plot.sci.ratio} for plotting the confidence intervals.

 }

\examples{

################################################

# Slope-ratio assay on data from Jensen(1989),
# Biometrical Journal 31, 841-853.

# Definition of the vector of responses and
# the design matrix can be done directly as
# follows:

Y0 <- c(1.3, 1.7, 2.4, 2.7, 3.6, 3.6, 4.7, 5.0, 6.1, 6.3)
Y1 <- c(2.8, 2.9, 4.1, 3.7, 5.5, 5.5, 6.4, 6.7)
Y2 <- c(2.2, 2.1, 3.2, 3.2, 3.8, 3.9, 4.7, 4.9)
Y3 <- c(2.3, 2.3, 3.2, 3.0, 4.2, 4.2, 4.6, 5.1)
Y <- c(Y0,Y1,Y2,Y3) # the response vector

xi <- rep(1,34)
x0 <- c(0,0, gl(4,2),rep(0,8*3))
x1 <- c(rep(0,10),gl(4,2), rep(0,8*2))
x2 <- c(rep(0,18),gl(4,2), rep(0,8))
x3 <- c(rep(0,26),gl(4,2))

X <- cbind(xi,x0,x1,x2,x3) # the design matrix

# Have a look at the response vector:
Y

# and the design matrix:

X

# Internally in sci.ratio.gen, the following model is fitted
 
Fiti <- lm(Y ~ X - 1)
Fiti
summary(Fiti)

# In this problem, interest is simultaneous estimation of
# the ratios of slopes relative to the slope of the standard
# treatment. Therefore, the appropriate contrast matrices are:

Num.Contrast <- matrix(c(0,0,1,0,0,
                         0,0,0,1,0,
                         0,0,0,0,1),nrow=3,byrow=TRUE)
Den.Contrast <- matrix(c(0,1,0,0,0,
                         0,1,0,0,0,
                         0,1,0,0,0),nrow=3,byrow=TRUE)



SlopeRatioCI <- sci.ratio.gen(Y=Y, X=X,
 Num.Contrast=Num.Contrast, Den.Contrast=Den.Contrast)

SlopeRatioCI

# Further details of the fitted model and the contrasts used:

summary(SlopeRatioCI)

plot(SlopeRatioCI)


#########################################################

\dontrun{

# If one starts with a dataframe, the function model.matrix
# can be used to create the design matrix:

data(SRAssay)
SRAssay

# Create the design matrix using model.matrix

X <- model.matrix(Response~Treatment:Dose, data=SRAssay)
Response <- SRAssay[,"Response"]

# The response vector and the design matrix are now:

X
Response

# The following coefficients result from fitting this model:

lm(Response~0+X)

# The same contrasts as above are used:

Num.Contrast <- matrix(c(0,0,1,0,0,
                         0,0,0,1,0,
                         0,0,0,0,1),nrow=3,byrow=TRUE)
Den.Contrast <- matrix(c(0,1,0,0,0,
                         0,1,0,0,0,
                         0,1,0,0,0),nrow=3,byrow=TRUE)

summary(sci.ratio.gen(Y=Response, X=X, Num.Contrast, Den.Contrast))

}
}
\keyword{ htest }
\concept{simultaneous confidence intervals}
\concept{general linear model}


