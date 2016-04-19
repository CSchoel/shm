library(tseriesChaos)

logistic <- function(x, r) {
  return(r * x * (1 - x))
}

step_size <- 0.01
rvals <- seq(2,4,step_size)
m <- 120
n <- length(rvals)
lexp <- array(0, n)
start_value <- 0.1
emb_dim <- 5
for(j in 1:n) {
  r <- rvals[j]
  data <- array(0, m)
  data[1] <- start_value
  for(i in 2:m) {
    data[i] <- logistic(data[i-1], r)
  }
  lexp[j] <- lyap_k(data, m=emb_dim, d=step_size, s=20, t=40, ref=50, k=2, eps=0.1)
}
