n <- 1000
peak <- 10
peak2 <- 990
smooth.radius <- 10
peak.value <- 20

data.dirac <- rep(0,n)
data.smooth <- rep(0,n)


data.dirac[peak] <- peak.value
#data.dirac[peak2] <- peak.value

for(i in (peak-smooth.radius):(peak+smooth.radius)) {
  x <- 1 - abs(peak-i)/smooth.radius
  data.smooth[i] <- peak.value * x^2
}
#for(i in (peak2-smooth.radius):(peak2+smooth.radius)) {
#  x <- 1 - abs(peak2-i)/smooth.radius
#  data.smooth[i] <- peak.value * x^2
#}
ifft.dirac <- fft(data.dirac,inverse=TRUE)
ifft.smooth <- fft(data.smooth,inverse=TRUE)

#plot(data.dirac,type="l",col="blue")
#lines(data.smooth,type="l",col="red")
plot(Re(ifft.dirac),type="l",col="blue")
lines(Re(ifft.smooth),type="l",col="red")

#sd <- rep(0,n)
#for(i in 1:n) {
#  sd[i] <- cos(i/n*100*pi)
#}
#plot(Re(fft(sd)),type="l")
