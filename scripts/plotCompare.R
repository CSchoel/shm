#Author: Christopher Sch�lzel
#Compares modelica output to SeidelThesis output
library(stats) #for fft
library(plotrix) #for gap.plot
library(ggplot2)
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
  "wNe.con.concentration",
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
names.display <- rep(expression(c),length(phinames))
names(names.display) <- names(phinames)
names.display["time"] <- "t"
names.display["sNe.con.concentration"] <- expression(c[sNe])
names.display["vNe.con.concentration"] <- expression(c[vNe])
names.display["wNe.con.concentration"] <- expression(c[wNe])
names.display["sAc.con.concentration"] <- expression(c[sAc])
names.display["sinus.phase"] <- expression(phi)
names.display["blood.vessel.pressure"] <- "p"
names.display["heart.S"] <- expression(S[n])
names.display["heart.contraction.T"] <- expression(paste(T[n],"[s]"))
names.display["baro.sat_signal"] <- expression(nu[b])
names.display["baro.signal.activation"] <- expression(nu[b])
names.display["lung.signal.activation"] <- expression(nu[r])
names.display["heart.tau_wind"] <- expression(tau[wind])
names.display["sym.signal.activation"] <- expression(nu[s])
names.display["para.signal.activation"] <- expression(nu[p])


compare.print.first <- function(phinames,dataMo,dataC) {
  # Prints starting values for given variables and highlights differences
  #
  # Args:
  #   phinames: (named) vector of variablenames found in dataC; the names(phinames)
  #             must contain the name of the corresponding variable in dataMo
  #   dataMo: modelica data as matrix
  #   dataC: java data as matrix
  for(moname in names(phinames)) {
    phiname = phinames[moname]
    moval = as.numeric(dataMo[1,moname])
    phival = dataC[1,phiname]
    if(moval == phival) {
      print(sprintf("%s/%s = %.6f",phiname,moname,moval))
    } else {
      print(sprintf("DIFFERENT VALUES FOR %s/%s: %.6f (C) vs %.6f (M)",phiname,moname,phival,moval))
    }
  }
}
compare.plot.all <- function(phinames,dataMo,dataC,combine=F,outdir="plots") {
  # Constructs a plot for all given variables from Modelica and C data.
  #
  # Args:
  #   phinames: (named) vector of variablenames found in dataC; the names(phinames)
  #             must contain the name of the corresponding variable in dataMo
  #   dataMo: modelica data as matrix
  #   dataC: java data as matrix
  #   combine: if TRUE, a single PDF (named "compare.pdf") will be created, otherwise
  #           one PDF will be created for each variable (named "compare-<variable>.pdf")
  #   outdir: the directory where to place the plots
  pdfheight <- 5
  pdfwidth <- 10
  if(!file.exists(outdir)) dir.create(outdir) #create output directory if necessary
  #extract time for x-axis of all plots
  timeMo <- dataMo[,"time"]
  timeC <- dataC[,"time"]
  if (combine) {
    pdfname <- file.path(outdir,"compare.pdf")
    combinedheight <- (length(phinames)-1)*pdfheight
    pdf(pdfname,width=pdfwidth,height=combinedheight)
    par(mfrow=c(length(phinames)-1,1)) #set number of subplots by row
  }
  for(moname in names(phinames)) {
    if(moname == "time") next
    phiname = phinames[moname]
    name.display <- names.display[moname]
    if(!combine) {
      pdfname <- sprintf("compare-%s%s.pdf",phiname,ifelse(phiname == "R","2",""))
      pdfname <- file.path(outdir,pdfname)
      pdf(pdfname,width=pdfwidth,height=pdfheight)
    }
    print(sprintf("%10s -> %s",phiname,pdfname))
    #construct plot; modelica data will determine plot bounds
    plot(timeMo,dataMo[,moname],type="l",col="red",xlab="time[s]",ylab=expression(name.display))
    #add additional line with lines instead of plot
    lines(timeC,dataC[,phiname],type="l",col="blue")
    #add legend in top right corner
    legend(x="topright",legend=c("Modelica","C"),lty=c(1,1),col=c("red","blue"),bg="white")
    if(!combine) {
      dev.off() #flush/close output file
    }
  }
  if(combine) {
    dev.off() #flush/close output file
  }
}
compare.plot.all.gap <- function(phinames,dataMo,dataC,gap,combine=F,outdir="plots") {
  # Constructs a plot for all given variables from Modelica and C data.
  #
  # Args:
  #   phinames: (named) vector of variablenames found in dataC; the names(phinames)
  #             must contain the name of the corresponding variable in dataMo
  #   dataMo: modelica data as matrix
  #   dataC: java data as matrix
  #   combine: if TRUE, a single PDF (named "compare.pdf") will be created, otherwise
  #           one PDF will be created for each variable (named "compare-<variable>.pdf")
  #   outdir: the directory where to place the plots
  pdfheight <- 5
  pdfwidth <- 10
  if(!file.exists(outdir)) dir.create(outdir) #create output directory if necessary
  #extract time for x-axis of all plots
  timeMo <- dataMo[,"time"]
  timeC <- dataC[,"time"]
  cut.offset <- (max(timeMo)-gap[2] + gap[1]-min(timeMo))*0.02
  gap[2] <- gap[2]-cut.offset
  dataMo.cut <- dataMo[which(timeMo <= gap[1] | timeMo >= gap[2]+cut.offset),]
  dataC.cut <- dataC[which(timeC <= gap[1] | timeC >= gap[2]+cut.offset),]
  timeMo.cut <- dataMo.cut[,"time"]
  timeC.cut <- dataC.cut[,"time"]
  xtick.step <- 10^floor(log10((max(timeMo)-gap[2])/2))
  xtick.gapr <- ceiling((gap[2]+cut.offset)/xtick.step)*xtick.step
  xticks <- append(seq(min(timeMo),gap[1],xtick.step),seq(xtick.gapr,max(timeMo),xtick.step))
  xticks.grid <- append(seq(min(timeMo),gap[1],xtick.step),seq(gap[1]+cut.offset,gap[1]+cut.offset+max(timeMo)-gap[2],xtick.step))
  if (combine) {
    pdfname <- file.path(outdir,"compare.pdf")
    combinedheight <- (length(phinames)-1)*pdfheight
    pdf(pdfname,width=pdfwidth,height=combinedheight)
    par(mfrow=c(length(phinames)-1,1)) #set number of subplots by row
  }
  for(moname in names(phinames)) {
    if(moname == "time") next
    phiname = phinames[moname]
    name.display <- names.display[moname]
    if(!combine) {
      pdfname <- sprintf("compare-%s%s.pdf",phiname,ifelse(phiname == "R","2",""))
      pdfname <- file.path(outdir,pdfname)
      pdf(pdfname,width=pdfwidth,height=pdfheight)
    }
    print(sprintf("%10s -> %s",phiname,pdfname))
    #construct plot; modelica data will determine plot bounds
    #to get grid lines add this parameter: panel.first={abline(v=xticks.grid, untf=FALSE, lty=3); grid(0,NULL)}
    gap.plot(timeMo.cut,dataMo.cut[,moname],gap,gap.axis="x",type="l",col="red",xlab="time[s]",ylab=name.display,xtics=xticks, xaxs="i")
    #add additional line
    gap.plot(timeC.cut,dataC.cut[,phiname],gap,gap.axis="x",type="l",col="blue",add=TRUE)
    #add legend in top right corner
    legend(x="topright",legend=c("Modelica","C"),lty=c(1,1),col=c("red","blue"),bg="white")
    if(!combine) {
      dev.off() #flush/close output file
    }
  }
  if(combine) {
    dev.off() #flush/close output file
  }
}

compare.plot2 <- function(phinames, dataMo, dataC, from, to) {
  crop <- function(data) { data[which(data[,"time"] >= from & data[,"time"] < to),] }
  dataMo2 <- data.frame(crop(dataMo))
  dataC2 <- data.frame(crop(dataC))
  ggplot() +
    theme_classic() +
    geom_line(data=dataMo2, aes(x=time, y=blood.vessel.pressure, colour="Modelica"), size=1.5) +
    geom_line(data=dataC2, aes_string(x="time",y=phinames["blood.vessel.pressure"], colour="\"C\""), size=1.5) +
    labs(x = "time[s]", y = "blood pressure [mmHg]") +
    theme(axis.text = element_text(size=20),
          axis.title=element_text(size=25),
          legend.text = element_text(size=20),
          legend.title = element_text(size=22),
          panel.grid.major = element_line(size=0.5, color="#AAAAAA"),
          axis.line = element_line(size=1.5, arrow=arrow(), lineend="square"),
          axis.ticks = element_line(size=1.5),
          axis.ticks.length = unit(10, "pt")) +
    labs(color="") +
    scale_x_continuous(expand=c(0,0))
  ggsave("plot2.pdf", width=9, height=6)
  #qplot(timeC, dataC2[,phinames["blood.vessel.pressure"]]) + geom_line()
  #qplot(timeMo, dataMo2[,"blood.vessel.pressure"]) + geom_line()
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
    if (idx.src-1 <= 0) {
      data.dest[idx.dest,] <- data.src[idx.src,]
    } else {
      t.src <- data.src[idx.src,ktime]
      dt.src <- t.src - data.src[idx.src-1,ktime]
      if(dt.src == 0) {
        #TODO we should actually take the next value
        fac.right <- 0
      } else {
        fac.right <- (t.src - t.dest) / dt.src
      }
      fac.left <- 1 - fac.right
      data.dest[idx.dest,] <- data.src[idx.src-1,]*fac.left + data.src[idx.src,]*fac.right
    }
  }
  return(data.dest)
}
get.frequencies <- function(data,samples.per.second=1) {
  N <- length(data)
  frequencies <- (Mod(fft(data))/N) #add square if power is needed
  #we have a real signal => values of frequencies are mirrored at N/2
  xvals <- 1:(N/2)/N #cycles per sample
  xvals <- samples.per.second * xvals
  return(cbind(xvals, frequencies[1:(N/2)]))
}
fft.convert <- function(data,kdata,ktime,sps,xmax) {
  data.size <- length(data[,ktime])
  duration <- data[data.size,ktime]-data[1,ktime]
  data.rs <- data.resample(data,ktime,0,duration,1/sps)
  data.rs.size <- length(data.rs[,ktime])
  frequencies <- get.frequencies(data.rs[,kdata],samples.per.second=sps)
  nfreq <- round(xmax*data.rs.size/sps)
  frequencies <- frequencies[2:nfreq,]
  return(frequencies)
}
compare.fft <- function(data1, data2, key1, key2, ktime1, ktime2, name1, name2, sps, outdir="plots") {
  pdfheight <- 5
  pdfwidth <- 10
  maxfreq <- 0.4
  frequencies1 <- fft.convert(data1,key1,ktime1,sps,maxfreq)
  frequencies2 <- fft.convert(data2,key2,ktime2,sps,maxfreq)
  pdf(file.path(outdir,sprintf("fft_%s.pdf",key1)),width=pdfwidth,height=pdfheight)
  xticks <- seq(0,maxfreq,0.05)
  ylab <- expression("RR-Interval spectral density" ~~ ~~ group("[","s","]"))
  plot(frequencies1,type="l",col="red",log="y",xlab="Frequency [Hz]",ylab=ylab,xlim=c(0,maxfreq),xaxs="i",xaxt="n")
  lines(frequencies2,type="l",col="blue")
  axis(side=1, at=xticks)
  legend(x="topright",legend=c(name1,name2),lty=c(1,1),col=c("red","blue"),bg="white")
  dev.off()
}
compare.diff <- function(data1, data2, ktime1, ktime2, kdata1, kdata2) {
  plot(data1[,ktime1],data1[,kdata1]-data2[,kdata2],type="l")
  lines(data1[,ktime1],data1[,kdata1],type="l",col="blue")
  lines(data2[,ktime2],data2[,kdata2],type="l",col="red")
}
compare.beats <- function(data1, data2,outdir="plots",nfirst=200) {
  pdfheight <- 5
  pdfwidth <- 10
  pdf(file.path(outdir,"beats_diff.pdf"),width=pdfwidth,height=pdfheight)
  n.beats <- min(length(data1[,1]),length(data2[,1]),nfirst)
  sd1 <- sd(data1[,2])
  pdat <- data2[1:n.beats,2]-data1[1:n.beats,2]
  print(pdat)
  print(sd1)
  print(mean(pdat))
  plot(1:n.beats,pdat,type="l",xlim=c(1, n.beats), ylim=c(-sd1*1.1,sd1*1.1),,xlab="i [beat number]",ylab="time [s]",panel.first= {grid()},xaxs="i",yaxs="i")
  #lines(1:n.beats,abs(pdat),type="l",col="red")
  lines(1:n.beats,rep(sd1,n.beats),type="l",col="blue")
  lines(1:n.beats,rep(-sd1,n.beats),type="l",col="blue")
  legend.diff <- expression(T[i]^M - T[i]^C ~~ " ")
  legend.sd <- expression(""%+-%sigma(T^C))
  legend(x="bottom",legend=c(legend.diff,legend.sd),lty=c(1,1),col=c("black","blue"),bg="white")
  dev.off()
}
compare.beattimes <- function(data1,data2) {
  n.beats <- min(length(data1[,1]),length(data2[,1]))
  sd1 <- sd(data1[,2])
  #xaxs = "i" removes margin from x axis
  plot(1:n.beats,data2[1:n.beats,1]-data1[1:n.beats,1],type="l",ylim=c(-sd1*1.1,sd1*1.1),,xlab="i [beat number]",ylab="time [s]")
  lines(1:n.beats,rep(sd1,n.beats),type="l",col="blue")
  lines(1:n.beats,rep(-sd1,n.beats),type="l",col="blue")
  legend.diff <- expression(t[i]^M - t[i]^C ~~ " ")
  legend.sd <- expression(""%+-%sigma(t^C))
  legend(x="bottom",legend=c(legend.diff,legend.sd),lty=c(1,1),col=c("black","blue"),bg="white")
}

nameMo <- "SHM_full_1000_res.csv" # "SHM_full_200_res.csv"
nameC <- "DeepThought1000.out" # "DeepThought.out"
nameMo.beats <- "heartbeats.csv"
nameC.beats <- "DeepThought1000.out_per" #"DeepThought.out_per"
n <- 1000
#load csv as matrix
cls <- rep("numeric",23)
#ignore empty row stemming from additional comma at end of line in modelica output
cls[23] <- "NULL"
dataMo <- as.matrix(read.csv(nameMo,sep=",",dec=".",header=T,colClasses=cls))
dataC <- as.matrix(read.csv(nameC,sep="\t",dec=".",header=T))
dataC[,"Pn"] <- dataC[,"Pn"]*2 #adjust Pn to obtain S

#load heartbeats files
dataMo.beats <- as.matrix(read.csv(nameMo.beats,sep=" ",dec=".",header=T))
dataC.beats <- as.matrix(read.csv(nameC.beats,sep="\t",dec=".",header=F))

#compare starting values
compare.print.first(phinames,dataMo,dataC)

#make frequency plots
compare.fft(dataMo,dataC,"heart.contraction.T",phinames["heart.contraction.T"],"time","time","SHM-M","SHM-C",100)

#limit part of the signal to take
from <-0# 980 #0
to <- 1000#999 #20
step <- 0.01 #0.01
dataMo2 <- data.resample(dataMo,"time",from,to,step)
dataC2 <- data.resample(dataC,"time",from,to,step)

#call plot function
gap <- c(5,995)
compare.plot.all.gap(phinames,dataMo2,dataC2,gap,T)
compare.plot.all.gap(phinames,dataMo2,dataC2,gap,F)
#compare.plot.all(phinames,dataMo2,dataC2,T)
#compare.plot.all(phinames,dataMo2,dataC2,F)
#compare.diff(dataMo2,dataC2,"time","time","blood.vessel.pressure",phinames["blood.vessel.pressure"])
#compare.diff(dataMo2,dataC2,"time","time","heart.contraction.T",phinames["heart.contraction.T"])
compare.beats(dataC.beats,dataMo.beats)

#make ggplot2 plots
compare.plot2(phinames, dataMo2, dataC2)
