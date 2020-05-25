#Author: Christopher Schölzel
#Makes plots from a single dataset

plot.all <- function(data,combine=F,outdir="plots") {
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
  time <- data[,"time"]
  if (combine) {
    pdfname <- file.path(outdir,"single.pdf")
    combinedheight <- (length(phinames)-1)*pdfheight
    pdf(pdfname,width=pdfwidth,height=combinedheight)
    par(mfrow=c(length(phinames)-1,1)) #set number of subplots by row
  }
  for(name in names(data[1,])) {
    if(name == "time") next
    if(!combine) {
      pdfname <- sprintf("single-%s.pdf",name)
      pdfname <- file.path(outdir,pdfname)
      pdf(pdfname,width=pdfwidth,height=pdfheight)
    }
    print(sprintf("%10s -> %s",name,pdfname))
    #construct plot
    plot(time,data[,name],type="l",col="red",xlab="time[s]",ylab=name)
    if(!combine) {
      dev.off() #flush/close output file
    }
  }
  if(combine) {
    dev.off() #flush/close output file
  }
}

name <- "DefaultParams.out"
name <- "DeepThought.out"
n <- 1000
#load csv as matrix
data <- as.matrix(read.table(name,header=T))
#limit part of the signal to take
portion <- 0.05
lenD <- length(data[,1])*portion
#subsample: take only n samples
data <- data[1:lenD,]
fac <- round(lenD/n)
data <- data[seq(1,lenD,fac),]
#call plot function
plot.all(data,T)
