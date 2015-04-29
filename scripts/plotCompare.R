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
    t.src <- data.src[idx.src,ktime]
    fac.right <- (t.src - t.dest) / step
    fac.left <- 1 - fac.right
    if (idx.src+1 > size.src) {
      data.dest[idx.dest,] <- data.src[idx.src]
    } else {
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
compare.fft <- function(data1, data2, key1, key2, name1, name2, duration, outdir="plots") {
  vector1 <- as.numeric(data1[,key1])
  vector2 <- as.numeric(data2[,key2])
  sps1 <- length(vector1)/duration
  sps2 <- length(vector2)/duration
  frequencies1 <- get.frequencies(vector1,samples.per.second=sps1)
  frequencies2 <- get.frequencies(vector2,samples.per.second=sps2)
  frequencies1 <- frequencies1[2:100,]
  frequencies2 <- frequencies2[2:100,]
  ylab <- expression("RR-Interval spectral density" ~~ ~~ group("[","s"^2,"]"))
  plot(frequencies1,type="l",col="red",log="y",xlab="Frequency [Hz]",ylab=ylab)
  lines(frequencies2,type="l",col="blue")
  legend(x="topright",legend=c(name1,name2),lty=c(1,1),col=c("red","blue"))
}

nameMo <- "SHM_full_200_res.csv"
nameJ <- "DeepThought.out"
n <- 1000
#load csv as matrix
dataMo <- as.matrix(read.csv(nameMo,sep=",",dec=".",header=T))
dataJ <- as.matrix(read.csv(nameJ,sep="\t",dec=".",header=T))
dataJ[,"Pn"] <- dataJ[,"Pn"]*2 #adjust Pn to obtain S

#make frequency plots
compare.fft(dataMo,dataJ,"heart.contraction.T",phinames["heart.contraction.T"],"SHM-M","SHM-C",200)

#limit part of the signal to take
portion <- 0.1
lenM <- length(dataMo[,1])*portion
lenJ <- length(dataJ[,1])*portion
#subsample: take only n samples
dataMo <- dataMo[1:lenM,]
dataJ <- dataJ[1:lenJ,]
facMo <- round(lenM/n)
dataMo <- dataMo[seq(1,lenM,facMo),]
facJ <- round(lenJ/n)
dataJ <- dataJ[seq(1,lenJ,facJ),]
#compare starting values
compare.print.first(phinames,dataMo,dataJ)
#call plot function
compare.plot.all(phinames,dataMo,dataJ,T)
compare.plot.all(phinames,dataMo,dataJ,F)
