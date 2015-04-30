"print.sci.ratio" <-
function(x, digits=4, ...)
{
cat(x$methodname, "\n")
if(!is.null(x$df)){
cat("Degree of freedom:", paste(signif(x$df, digits), collapse=", "), ", quantile:", paste(signif(x$quantile, digits), collapse=", "), "\n", sep="")
}else{
cat("Normal approximation, quantile:", paste(signif(x$quantile, digits), collapse=", "), "\n", sep="")
}
if(x$NSD)
{
 print(cbind(estimate=x$estimate, x$conf.int) )

 cat("   NSD = The mean in the denominator is not significantly different from zero. ","\n")

}
else
{

print(cbind(estimate=x$estimate, x$conf.int), digits=digits, ...)

}
invisible(x)
}

