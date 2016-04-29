library(pracma)
n <- 10000
data <- runif(n,-1,1)
data <- seq(0,n-1)
data <- cumsum(runif(n,-1,1))
data <- sin(seq(0,n-1)/(n-1)*pi*100)
print(data)
hurstexp(data)
