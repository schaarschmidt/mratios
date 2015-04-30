\name{sci.ratio}
\alias{sci.ratio}
\alias{sci.ratioI}


\title{ Simultaneous confidence intervals for ratios of linear combinations of means }

\description{
  This function constructs simultaneous confidence intervals for ratios of linear combinations of normal means in a one-way ANOVA model.
  Different methods are available for multiplicity adjustment.
}
\usage{
sci.ratio(formula, data, type = "Dunnett", base = 1,
 method = "Plug", Num.Contrast = NULL, Den.Contrast = NULL,
 alternative = "two.sided", conf.level = 0.95, names=TRUE)

}

\arguments{
  \item{formula}{ A formula specifying a numerical response and a grouping factor as e.g. \kbd{response ~ treatment} }
  \item{data}{  A dataframe containing the response and group variable }
  \item{type}{ type of contrast, with the following options:
    \itemize{

    \item \bold{"Dunnett":} many-to-one comparisons, with the control group in the denominator

    \item \bold{"Tukey":} all-pair comparisons 

    \item \bold{"Sequen":} comparison of consecutive groups, where the group with lower order is the denominator
 
    \item \bold{"AVE":} comparison of each group with average of all others, where the average is taken as denominator

    \item \bold{"GrandMean":} comparison of each group with grand mean of all groups, where the grand mean is taken as denominator

    \item \bold{"Changepoint":} ratio of averages of groups of higher order divided by averages of groups of lower order 

    \item \bold{"Marcus":} Marcus contrasts as ratios 

    \item \bold{"McDermott":} McDermott contrasts as ratios 

    \item \bold{"Williams":} Williams contrasts as ratios 

    \item \bold{"UmbrellaWilliams":} Umbrella-protected Williams contrasts as ratios

    }
 Note: \kbd{type} is ignored, if \kbd{Num.Contrast} and \kbd{Den.Contrast} are specified by the user (See below).
}
  \item{base}{ a single integer specifying the control (i.e. denominator) group for the Dunnett contrasts, ignored otherwise }
  \item{method}{ 
    character string specifying the method to be used for confidence interval construction:
\itemize{
    \item \bold{"Plug":} Plug-in of ratio estimates in the correlation matrix of the multivariate t distribution. This method is the default.
    \item \bold{"Bonf":} Simple Bonferroni-adjustment of Fieller confidence intervals for the ratios 
    \item \bold{"MtI":} Sidak or Slepian- adjustment for two-sided and one-sided confidence intervals, respectively  
    \item \bold{"Unadj":} Unadjusted Fieller confidence intervals for the ratios (i.e. with comparisonwise confidence level = conf.level) 
    }
  }
  \item{Num.Contrast}{ Numerator contrast matrix, where columns correspond to groups and rows correspond to contrasts  }
  \item{Den.Contrast}{ Denominator contrast matrix, where columns correspond to groups and rows correspond to contrasts }
  \item{alternative}{ a character string: "two.sided" for two-sided intervals, "less" for upper confidence limits, "greater" for lower confidence limits }
  \item{conf.level}{ simultaneous confidence level in case of method="Plug","Bonf", or "MtI", and comparisonwise confidence level in case of method="Unadj" }
  \item{names}{logical, indicating whether rownames of the contrast matrices shall be retained in the output}
}
\details{

Given a one-way ANOVA model, the interest is in simultaneous confidence intervals
for several ratios of linear combinations of the treatment means. It is assumed that the
responses are normally distributed with homogeneous variances. Unlike in multiple testing
for ratios, the joint distribution of the likelihood ratio statistics has a multivariate t-distribution
the correlation matrix of which depends on the unknown ratios. This means that the critical
point needed for CI calculations also depends on the ratios. There are various methods
of dealing with this problem (for example, see Dilba et al., 2006). The methods include (i) the unadjusted
intervals (Fieller confidence intervals without multiplicity adjustments), (ii) Bonferroni (Fieller
intervals with simple Bonferroni adjustments), (iii) MtI (a method based on Sidak and Slepian
inequalities for two- and one-sided confidence intervals, respectively), and (iv) plug-in (plugging
the maximum likelihood estimates of the ratios in the unknown correlation matrix). The latter
method is known to have good simultaneous coverage probabilities. The MtI method consists
of replacing the unknown correlation matrix of the multivariate t by an identity matrix of the
same dimension.

See the examples for the usage of Numerator and Denominator contrasts.
Note that the argument names Num.Contrast and Den.Contrast need to be specified. If numerator and denominator contrasts are plugged in without
their argument names, they will not be recognized.  

}
\value{
  An object of class "sci.ratio", containing a list with elements:
  \item{estimate }{point estimates of the ratios}
  \item{CorrMat.est }{estimate of the correlation matrix (for the plug-in approach)}
  \item{Num.Contrast }{matrix of contrasts used for the numerator of ratios}
  \item{Den.Contrast }{matrix of contrasts used for the denominator of ratios}
  \item{conf.int }{confidence interval estimates of the ratios}

And some further elements to be passed to print and summary functions.
}
\references{ 
 Dilba, G., Bretz, F., and Guiard, V. (2006): Simultaneous confidence sets and confidence intervals for multiple ratios. Journal of Statistical Planning and Inference 136, 2640-2658.
 }
\author{ Gemechis Dilba Djira}

\seealso{ \kbd{glht(multcomp)} for simultaneous CI of differences of means,
          \link{plot.sci.ratio} for a plotting function of the intervals }

\examples{


# # #

# A 90-days chronic toxicity assay: 
# Which of the doses (groups 2,3,4) do not show a decrease in
# bodyweight more pronounced than 90 percent of the bodyweight
# in the control group?

data(BW)

boxplot(Weight~Dose,data=BW)

BWnoninf <- sci.ratio(Weight~Dose, data=BW, type="Dunnett",
 alternative="greater")

plot(BWnoninf, rho0=0.9)

\dontrun{
# # #

# Antibiotic activity of 8 different strains of a micro organisms.
# (Horn and Vollandt, 1995): 

data(Penicillin)

boxplot(diameter~strain, data=Penicillin)

allpairs<-sci.ratio(diameter~strain, data=Penicillin, type="Tukey")
plot(allpairs)
summary(allpairs)

}

}

\keyword{ htest }
\concept{simultaneous confidence intervals}
\concept{ratio}