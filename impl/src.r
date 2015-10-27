data.dir <- file.path('D:', 'dev', 'ill_stat_proj', 'data')
setwd(data.dir)

flu.data.full <- as.numeric(as.character(read.table('flu_full.txt')$V1))
inf.data.full <- as.numeric(as.character(read.table('inf_full.txt')$V1))

#flu.data <- as.numeric(read.table('flu01020304.txt')$V1)
#inf.data <- as.numeric(read.table('inf01020304.txt')$V1)

flu.data.avg <- as.numeric(as.character(read.table('flu.avg.txt')$V1))
inf.data.avg <- as.numeric(as.character(read.table('inf.avg.txt')$V1))

plot(inf.data.full, flu.data.full, xlim=c(0, 2500), ylim = c(0, 200))
#plot(flu.data, inf.data, xlim=c(0, 2000), ylim = c(0, 40000))
#plot(flu.data.avg, inf.data.avg, xlim=c(0, 100), ylim = c(0, 2000))

fit <- nls(flu.data.full ~ a+b*inf.data.full+c*log(inf.data.full), start=c(a=0, b=0, c=0))
#fit <- nls(flu.data.avg ~ a+b*inf.data.avg+c*log(inf.data.avg), start=c(a=0, b=0, c=0))
#xvals = 1:1500
#yvals = xvals
#for (x in xvals) yvals[x] = 210 + 0.1*x-42.2*log(x)
#lines(xvals, yvals)

fix.data <- function(i.inf.data, i.flu.data, i.log.coef, i.min.value.to.fix=500)
{
  stopifnot(length(i.inf.data)==length(i.flu.data))
  for (idx in 1:length(i.inf.data))
  {
    if (i.inf.data[idx] >= i.min.value.to.fix)
    {
      delta = i.log.coef*log(i.inf.data[idx])
      i.inf.data[idx] = i.inf.data[idx] - delta/2
      i.flu.data[idx] = i.flu.data[idx] + delta/2
    }
  }
  
  return(list(i.inf.data, i.flu.data))
}

fixed.data <- fix.data(inf.data.full, flu.data.full, 12, 0)
plot(inf.data.full, flu.data.full)
lines(fixed.data[[1]], fixed.data[[2]], type="p", col="green")

