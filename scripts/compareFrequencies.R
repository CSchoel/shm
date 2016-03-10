get.frequencies <- function(data,samples.per.second=1) {
  N <- length(data)
  frequencies <- (Mod(fft(data))/N)^2
  #we have a real signal => values of frequencies are mirrored at N/2
  xvals <- 1:(N/2)/N #cycles per sample
  xvals <- samples.per.second * xvals
  return(cbind(xvals, frequencies[1:(N/2)]))
}
compare.fft <- function(data1, data2, duration, outdir="plots") {
  sps1 <- length(data1)/duration
  sps2 <- length(data2)/duration
  frequencies1 <- get.frequencies(data1,samples.per.second=sps1)
  frequencies2 <- get.frequencies(data2,samples.per.second=sps2)
  frequencies1 <- frequencies1[1:100,]
  plot(frequencies1,type="l",col="red")
  #plot(frequencies2,type="l",col="blue")
}

nameM <- "heartbeats.csv"
nameC <- "DeepThought.out_per"
dataM <- as.matrix(read.table(nameM,header=T))
dataC <- as.matrix(read.table(nameC,header=F))

#make frequency plots
compare.fft(dataMo,dataJ,"heart.contraction.T",phinames["heart.contraction.T"],200)
