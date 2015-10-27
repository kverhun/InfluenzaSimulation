data.dir <- file.path('D:', 'dev', 'ill_stat_proj', 'data')
setwd(data.dir)

infl.data.full <- as.numeric(as.character(read.table('influenza_all.txt')$V1))
ili.data.full <- as.numeric(as.character(read.table('ili_all.txt')$V1))

#print(infl.data.full)
#print(ili.data.full)

state.number <- 27

infl.matrix <- t(matrix(infl.data.full, ncol=state.number))
ili.matrix <- t(matrix(ili.data.full, ncol=state.number))

# Influenza = a + b*ILI + c*ln(ILI)
#    a  b  c
# #1 -  -  -
# #2 -  -  -
# ...........
coef.matrix <- matrix(ncol=3, nrow=state.number)

for (i in 1:state.number)
{
  fit <- nls(infl.matrix[i,] ~ a+b*ili.matrix[i,]+c*log(ili.matrix[i,]), start=c(a=0, b=0, c=0))
  coef.matrix[i,] <- summary(fit)$coefficients[,1]
  print(summary(fit)$coefficients)
}

fixed.infl.matrix <- infl.matrix
fixed.ili.matrix  <- ili.matrix

for (i in 1:state.number)
  for (j in 1:ncol(infl.matrix))
  {
    delta = coef.matrix[i, 3]*log(infl.matrix[i,j])
    infl.add.value = -delta/2
    if(infl.add.value > 0)
    {
      # to make sure all values are >= 0
      if (ili.matrix[i,j] - infl.add.value < 0.0)
        infl.add.value <- ili.matrix[i,j]
        
      fixed.infl.matrix[i,j] <- infl.matrix[i,j] +infl.add.value
      fixed.ili.matrix[i,j]  <- ili.matrix[i,j] - infl.add.value  
    }    
  }

plot(as.vector(fixed.infl.matrix), as.vector(fixed.ili.matrix))

for (i in 1:state.number)
{
  plot(fixed.infl.matrix[i,], fixed.ili.matrix[i,], col="green", type="p", cex=2)
  #lines(fixed.data[[1]], fixed.data[[2]], type="p", col="green")
  lines(infl.matrix[i,], ili.matrix[i,], type="p", col="red")
}


