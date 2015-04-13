#Author: Christopher Sch�lzel
#Compares modelica output to SeidelThesis output
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
  "tau_w"
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
  "heart.tau_wind"
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
nameMo <- "SHM_full_200_res.csv"
nameJ <- "DeepThought.out"
n <- 1000
#load csv as matrix
dataMo <- as.matrix(read.csv(nameMo))
dataJ <- as.matrix(read.table(nameJ,header=T))
dataJ[,"Pn"] <- dataJ[,"Pn"]*2 #adjust Pn to obtain S
#subsample: take only n samples
lenM <- length(dataMo[,1])
lenJ <- length(dataJ[,1])
facMo <- round(lenM/n)
dataMo <- dataMo[seq(1,lenM,facMo),]
facJ <- round(lenJ/n)
dataJ <- dataJ[seq(1,lenJ,facJ),]
dataMo <- dataMo[1:100,]
dataJ <- dataJ[1:100,]
#compare starting values
compare.print.first(phinames,dataMo,dataJ)
#call plot function
compare.plot.all(phinames,dataMo,dataJ,T)
compare.plot.all(phinames,dataMo,dataJ,F)
