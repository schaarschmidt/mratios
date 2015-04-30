\name{simtest.ratio}

\alias{simtest.ratio}
\alias{simtest.ratioI}


\title{ Simultaneous tests for ratios of normal means  }
\description{
Performs simultaneous tests for several ratios of linear combinations of treatment means in the normal one-way ANOVA model with homogeneous variances.
  
}
\usage{
simtest.ratio(formula, data, type = "Dunnett", base = 1,
 alternative = "two.sided", Margin.vec = NULL, FWER = 0.05,
 Num.Contrast = NULL, Den.Contrast = NULL, names = TRUE)
}
\arguments{
  \item{formula}{ A formula specifying a numerical response and a grouping factor (e.g., response ~ treatment) }
  \item{data}{  A dataframe containing the response and group variable }
  \item{type}{ type of contrast, with the following options:
  \itemize{
    \item \bold{"Dunnett":} many-to-one comparisons, with control in the denominator
    \item \bold{"Tukey":} all-pair comparisons 
    \item \bold{"Sequen":} comparison of consecutive groups, where the group with lower order is the denomniator
    \item \bold{"AVE":} comparison of each group with average of all others, where the average is taken as denominator
    \item \bold{"GrandMean":} comparison of each group with grand mean of all groups, where the grand mean is taken as denominator
    \item \bold{"Changepoint":} ratio of averages of groups of higher order divided by averages of groups of lower order 
    \item \bold{"Marcus":} Marcus contrasts as ratios 
    \item \bold{"McDermott":} McDermott contrasts as ratios 
    \item \bold{"Williams":} Williams contrasts as ratios 
    \item \bold{"UmbrellaWilliams":} Umbrella-protected Williams contrasts as ratios
    }
 Note: type is ignored if Num.Contrast and Den.Contrast are specified by the user (See below).
}
  \item{base}{ a single integer specifying the control (i.e. denominator) group for the Dunnett contrasts, ignored otherwise }
  \item{alternative}{ a character string:
    \itemize{
    \item \bold{"two.sided":} for two-sided tests 
    \item \bold{"less":} for lower tail tests 
    \item \bold{"greater":} for upper tail tests 
}}
  \item{Margin.vec}{ a single numerical value or vector of Margins under the null hypotheses, default is 1 }
  \item{FWER}{ a single numeric value specifying the family-wise error rate to be controlled }
  \item{Num.Contrast}{ Numerator contrast matrix, where columns correspond to groups and rows correspond to contrasts  }
  \item{Den.Contrast}{ Denominator contrast matrix, where columns correspond to groups and rows correspond to contrasts }
  \item{names}{ a logical value: if TRUE, the output will be named according to names of user defined contrast or factor levels }
  
}
\details{
 
Given a one-way ANOVA model, the interest is in simultaneous tests for several ratios of linear combinations of the treatment means.
 Let us denote the ratios by \eqn{\gamma_i, i=1,...,r}, and let \eqn{\psi_i, i=1,...,r}, denote the relative margins against which we compare the ratios.
 For example, upper-tail simultaneous tests for the ratios are stated as

\deqn{H_0i: \gamma_i <= \psi_i }

 versus

\deqn{H_1i: \gamma_i > \psi_i, i=1,...,r}.

The associated likelihood ratio test statistic \eqn{T_i} has a t-distribution.
 For multiplicity adjustments, we use the joint distribution of the \eqn{T_i} , \eqn{i=1,...,r},
 which under the null hypotheses follows a central r-variate t-distribution.
 Adjusted p-values can be calculated by adapting the results of Westfall et al. (1999) for ratio formatted hypotheses.

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

\emph{Dilba, G., Bretz, F., and Guiard, V. (2006).}
 Simultaneous confidence sets and confidence intervals for multiple ratios.
 \emph{Journal of Statistical Planning and Inference 136, 2640-2658.}

\emph{Westfall, P.H., Tobias, R.D., Rom, D., Wolfinger, R.D., and Hochberg, Y. (1999).}
 Multiple comparisons and multiple tests using the SAS system. SAS Institute Inc. Cary, NC, 65-81.

 }
\author{ Gemechis Dilba Djira }

\seealso{ While print.simtest.ratio produces a small default print-out of the results,
 
 summary.simtest.ratio can be used to produce a more detailed print-out, which is recommended if user-defined contrasts are used,

 sci.ratio for constructing simultaneous confidence intervals for ratios in oneway layout 

 See \kbd{summary.glht(multcomp)} for multiple tests for parameters of lm, glm.
 }


\examples{

library(mratios)

########################################################

# User-defined contrasts for comparisons
# between Active control, Placebo and three dosage groups:

data(AP)
AP
boxplot(prepost~treatment, data=AP)

# Test whether the differences of doses 50, 100, 150 vs. Placebo
# are non-inferior to the difference of Active control vs. Placebo 

# User-defined contrasts:

# Numerator Contrasts:

NC <- rbind(
"(D100-D0)" = c(0,-1,1,0,0),
"(D150-D0)" = c(0,-1,0,1,0),
 "(D50-D0)" = c(0,-1,0,0,1))

# Denominator Contrasts:

DC <- rbind(
"(AC-D0)" = c(1,-1,0,0,0),
"(AC-D0)" = c(1,-1,0,0,0),
"(AC-D0)" = c(1,-1,0,0,0))

NC
DC

noninf <- simtest.ratio(prepost ~ treatment, data=AP,
 Num.Contrast=NC, Den.Contrast=DC, Margin.vec=c(0.9,0.9,0.9),
 alternative="greater")

summary( noninf )


#########################################################

\dontrun{

# Some more examples on standard multiple comparison procedures
# stated in terms of ratio hypotheses:

# Comparisons vs. Control:

many21 <- simtest.ratio(prepost ~ treatment, data=AP,
 type="Dunnett")

summary(many21)

# Let the Placebo be the control group, which is the second level
# in alpha-numeric order. A simultaneous test for superiority of
# the three doses and the Active control vs. Placebo could be
# done as: 

many21P <- simtest.ratio(prepost ~ treatment, data=AP,
 type="Dunnett", base=2, alternative="greater", Margin.vec=1.1)
summary(many21P)

# All pairwise comparisons:

allpairs <- simtest.ratio(prepost ~ treatment, data=AP,
 type="Tukey")

summary(allpairs)

#######################################################

# Comparison to grand mean of all strains
# in the Penicillin example:

data(Penicillin)

CGM <- simtest.ratio(diameter~strain, data=Penicillin, type="GrandMean")
CGM
summary(CGM)

}

}

\keyword{ htest }
\concept{ratio}
\concept{multiple testing}
