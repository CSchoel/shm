#Author: Christopher Sch�lzel
#Compares modelica output to SeidelThesis output
library(stats)
phinames <- c(
  "time",
  "c_s",
  "c_c",
  "c_v",
  "c_ac",
  "phi",
  "p",
  "Pn",
  "Tn",
#  "Tavn",
  "ny_b",
  "ny_b_broadened",
  "ny_r",
  "tau_w",
  "ny_ss",
  "ny_p"
)
names(phinames) <- c(
  "time",
  "sNe.con.concentration",
  "vNe.con.concentration",
  "rNe.con.concentration",
  "sAc.con.concentration",
  "sinus.phase",
  "blood.vessel.pressure",
  "heart.S",
  "heart.contraction.T",
  #"heart.contraction.T_avc",
  "baro.sat_signal",
  "baro.signal.activation",
  "lung.signal.activation",
  "heart.tau_wind",
  "sym.signal.activation",
  "para.signal.activation"
)
compare.print.first <- function(phinames,dataMo,dataJ) {
  # Prints starting values for given variables and highlights differences
  # 
  # Args:
  #   phinames: (named) vector of variablenames found in dataJ; the names(phinames)
  #             must contain the name of the corresponding variable in dataMo
  #   dataMo: modelica data as matrix
  #   dataJ: java data as matrix
  for(moname in names(phinames)) {
    phiname = phinames[moname]
    moval = as.numeric(dataMo[1,moname])
    phival = dataJ[1,phiname]
    if(moval == phival) {
      print(sprintf("%s/%s = %.6f",phiname,moname,moval))
    } else {
      print(sprintf("DIFFERENT VALUES FOR %s/%s: %.6f (C) vs %.6f (M)",phiname,moname,phival,moval))
    }
  }
}
compare.plot.all <- function(phinames,dataMo,dataJ,combine=F,outdir="plots") {
  # Constructs a plot for all given variables from Modelica and Java data.
  #
  # Args:
  #   phinames: (named) vector of variablenames found in dataJ; the names(phinames)
  #             must contain the name of the corresponding variable in dataMo
  #   dataMo: modelica data as matrix
  #   dataJ: java data as matrix
  #   combine: if TRUE, a single PDF (named "compare.pdf") will be created, otherwise 
  #           one PDF will be created for each variable (named "compare-<variable>.pdf")
  #   outdir: the directory where to place the plots
  pdfheight <- 5
  pdfwidth <- 10
  if(!file.exists(outdir)) dir.create(outdir) #create output directory if necessary
  #extract time for x-axis of all plots
  timeMo <- dataMo[,"time"]
  timeJ <- dataJ[,"time"]
  if (combine) {
    pdfname <- file.path(outdir,"compare.pdf")
    combinedheight <- (length(phinames)-1)*pdfheight
    pdf(pdfname,width=pdfwidth,height=combinedheight)
    par(mfrow=c(length(phinames)-1,1)) #set number of subplots by row
  }
  for(moname in names(phinames)) {
    if(moname == "time") next
    phiname = phinames[moname]
    if(!combine) {
      pdfname <- sprintf("compare-%s%s.pdf",phiname,ifelse(phiname == "R","2",""))
      pdfname <- file.path(outdir,pdfname)
      pdf(pdfname,width=pdfwidth,height=pdfheight)
    }
    print(sprintf("%10s -> %s",phiname,pdfname))
    #construct plot; modelica data will determine plot bounds
    plot(timeMo,dataMo[,moname],type="l",col="red",xlab="time[s]",ylab=phiname)
    #add additional line with lines instead of plot
    lines(timeJ,dataJ[,phiname],type="l",col="blue")
    #add legend in top right corner
    legend(x="topright",legend=c("Modelica","C"),lty=c(1,1),col=c("red","blue"))
    if(!combine) {
      dev.off() #flush/close output file
    }
  }
  if(combine) {
    dev.off() #flush/close output file
  }
}
data.resample <- function(data.src,ktime,from,to,step) {
  span <- to - from
  size.src <- length(data.src[,ktime])
  time.steps <- seq(from,to,step)
  size.dest <- length(time.steps)
  data.dest <- matrix(,nrow=size.dest,ncol=length(data.src[1,]))
  colnames(data.dest) <- colnames(data.src)
  idx.src <- 1 #index in source file
  for(idx.dest in 1:size.dest) {
    t.dest <- time.steps[idx.dest]
    while(idx.src <= size.src && data.src[idx.src,ktime] < t.dest) {
      idx.src <- idx.src + 1
    }
    if (idx.src+1 > size.src) {
      data.dest[idx.dest,] <- data.src[idx.src]
    } else {
      t.src <- data.src[idx.src,ktime]
      dt.src <-  data.src[idx.src+1,ktime] - t.src
      fac.right <- (t.src - t.dest) / dt.src
      fac.left <- 1 - fac.right
      data.dest[idx.dest,] <- data.src[idx.src,]*fac.left + data.src[idx.src+1,]*fac.right
    }
  }
  return(data.dest)
}
get.frequencies <- function(data,samples.per.second=1) {
  N <- length(data)
  frequencies <- (Mod(fft(data))/N)^2
  #we have a real signal => values of frequencies are mirrored at N/2
  xvals <- 1:(N/2)/N #cycles per sample
  xvals <- samples.per.second * xvals
  return(cbind(xvals, frequencies[1:(N/2)]))
}
fft.convert <- function(data,kdata,ktime,sps) {
  data.size <- length(data[,ktime])
  duration <- data[data.size,ktime]-data[1,ktime]
  data.rs <- data.resample(data1,0,duration,1/sps)
  data.rs.size <- length(data[,ktime])
  frequencies <- get.frequencies(data.rs[,kdata],samples.per.second=sps)
  nfreq <- round(0.4*data.rs.size/sps)
  frequencies <- frequencies[2:nfreq1,]
  return(frequencies)
}
compare.fft <- function(data1, data2, key1, key2, ktime1, ktime2, name1, name2, sps, outdir="plots") {
  pdfheight <- 5
  pdfwidth <- 10
  maxfreq <- 0.4
  data1.rs <- data.resample(data1,0,duration,1/sps)
  data2.rs <- data.resample(data2,0,duration,1/sps)
  vector1 <- as.numeric(data1[,key1])
  vector2 <- as.numeric(data2[,key2])
  #determine length of data in seconds
  duration1 <- data1[length(vector1),ktime1]-data1[1,ktime1]
  duration2 <- data2[length(vector2),ktime2]-data2[1,ktime2]
  sps1 <- length(vector1)/duration1
  sps2 <- length(vector2)/duration2
  print(paste(duration1," ",sps1," ",duration2," ",sps2))
  frequencies1 <- get.frequencies(vector1,samples.per.second=sps1)
  frequencies2 <- get.frequencies(vector2,samples.per.second=sps2)
  nfreq1 <- round(0.4*length(vector1)/sps1)
  nfreq2 <- round(0.4*length(vector2)/sps2)
  frequencies1 <- frequencies1[2:nfreq1,]
  frequencies2 <- frequencies2[2:nfreq2,]
  pdf(file.path(outdir,paste("fft_",key1,".pdf")),width=pdfwidth,height=pdfheight)
  
  ylab <- expression("RR-Interval spectral density" ~~ ~~ group("[","s"^2,"]"))
  plot(frequencies1,type="l",col="red",log="y",xlab="Frequency [Hz]",ylab=ylab)
  lines(frequencies2,type="l",col="blue")
  legend(x="topright",legend=c(name1,name2),lty=c(1,1),col=c("red","blue"))
  dev.off()
}
compare.diff <- function(data1, data2, ktime1, ktime2, kdata1, kdata2) {
  plot(data1[,ktime1],data1[,kdata1]-data2[,kdata2],type="l")
  lines(data1[,ktime1],data1[,kdata1],type="l",col="blue")
  lines(data2[,ktime2],data2[,kdata2],type="l",col="red")
}
compare.beats <- function(data1, data2,outdir="plots") {
  pdfheight <- 5
  pdfwidth <- 10
  pdf(file.path(outdir,paste("beats_diff.pdf")),width=pdfwidth,height=pdfheight)
  n.beats <- min(length(data1[,1]),length(data2[,1]))
  sd1 <- sd(data1[,2])
  pdat <- data2[1:n.beats,2]-data1[1:n.beats,2]
  print(pdat)
  print(sd1)
  print(mean(pdat))
  plot(1:n.beats,pdat,type="l",ylim=c(-sd1*1.1,sd1*1.1),,xlab="i [beat number]",ylab="time [s]")
  lines(1:n.beats,abs(pdat),type="l",col="red")
  lines(1:n.beats,rep(sd1,n.beats),type="l",col="blue")
  lines(1:n.beats,rep(-sd1,n.beats),type="l",col="blue")
  legend.diff <- expression(T[i]^M - T[i]^C ~~ " ")
  legend.sd <- expression(""%+-%sigma(T^C))
  legend(x="bottom",legend=c(legend.diff,legend.sd),lty=c(1,1),col=c("black","blue"))
  dev.off()
}
compare.beattimes <- function(data1,data2) {
  n.beats <- min(length(data1[,1]),length(data2[,1]))
  sd1 <- sd(data1[,2])
  plot(1:n.beats,data2[1:n.beats,1]-data1[1:n.beats,1],type="l",ylim=c(-sd1*1.1,sd1*1.1),,xlab="i [beat number]",ylab="time [s]")
  lines(1:n.beats,rep(sd1,n.beats),type="l",col="blue")
  lines(1:n.beats,rep(-sd1,n.beats),type="l",col="blue")
  legend.diff <- expression(t[i]^M - t[i]^C ~~ " ")
  legend.sd <- expression(""%+-%sigma(t^C))
  legend(x="bottom",legend=c(legend.diff,legend.sd),lty=c(1,1),col=c("black","blue"))
}

nameMo <- "SHM_full_1000_res.csv" # "SHM_full_200_res.csv"
nameC <- "DeepThought1000.out" # "DeepThought.out"
nameMo.beats <- "heartbeats.csv"
nameC.beats <- "DeepThought.out_per"
n <- 1000
#load csv as matrix
cls <- rep("numeric",23)
#ignore empty row stemming from additional comma at end of line in modelica output
cls[23] <- "NULL"
dataMo <- as.matrix(read.csv(nameMo,sep=",",dec=".",header=T,colClasses=cls))
dataC <- as.matrix(read.csv(nameC,sep="\t",dec=".",header=T))
dataC[,"Pn"] <- dataC[,"Pn"]*2 #adjust Pn to obtain S

#load heartbeats files
dataMo.beats <- as.matrix(read.table(nameMo.beats,header=T))
dataC.beats <- as.matrix(read.table(nameC.beats,header=F))

#compare starting values
compare.print.first(phinames,dataMo,dataJ)

#make frequency plots
compare.fft(dataMo,dataC,"heart.contraction.T",phinames["heart.contraction.T"],"time","time","SHM-M","SHM-C",1000)

#limit part of the signal to take
from <-0# 980 #0
to <- 20#999 #20
step <- 0.01 #0.01
dataMo2 <- data.resample(dataMo,"time",from,to,step)
dataC2 <- data.resample(dataC,"time",from,to,step)

#call plot function
compare.plot.all(phinames,dataMo2,dataC2,T)
compare.plot.all(phinames,dataMo2,dataC2,F)
#compare.diff(dataMo2,dataC2,"time","time","blood.vessel.pressure",phinames["blood.vessel.pressure"])
#compare.diff(dataMo2,dataC2,"time","time","heart.contraction.T",phinames["heart.contraction.T"])
compare.beats(dataC.beats,dataMo.beats)
