#Author: Christopher Schölzel
varnames <- c(
  "time",
  "pressure",
  "phi",
  "baro",
  "para",
  "symp",
  "cNe",
  "vNe",
  "r",
  "resp-phase"
)
names(varnames) <- c(
  "time",
  "blood.vessel.pressure",
  "sinus.phase",
  "baro.signal.activation",
  "para.signal.activation",
  "symp.signal.activation",
  "cNeAmount.con.concentration",
  "vNeAmount.con.concentration",
  "lung.r",
  "lung.resp.phase"
)
modelica.plot.all <- function(varnames,data,combine=F,outdir="plots") {
  # Constructs a plot for all given variables from Modelica and Java data.
  #
  # Args:
  #   varnames: (named) vector of variablenames found in dataJ; the names(phinames)
  #             must contain the name of the corresponding variable in dataMo
  #   data: modelica data as matrix
  #   outdir: the directory where to place the plots
  pdfheight <- 5
  pdfwidth <- 10
  if(!file.exists(outdir)) dir.create(outdir) #create output directory if necessary
  #extract time for x-axis of all plots
  time <- data[,"time"]
  if (combine) {
    pdfname <- file.path(outdir,"MoKoMo.pdf")
    combinedheight <- (length(varnames)-1)*pdfheight
    pdf(pdfname,width=pdfwidth,height=combinedheight)
    par(mfrow=c(length(varnames)-1,1)) #set number of subplots by row
  }
  for(var in names(varnames)) {
    if(var == "time") next
    name = varnames[var]
    if(!combine) {
      pdfname <- sprintf("MoKoMo-%s.pdf",name)
      pdfname <- file.path(outdir,pdfname)
      pdf(pdfname,width=pdfwidth,height=pdfheight)
    }
    print(sprintf("%10s -> %s",name,pdfname))
    #construct plot; modelica data will determine plot bounds
    plot(time,data[,var],type="l",col="red",xlab="time[s]",ylab=name)
    #add legend in top right corner
    #legend(x="topright",legend=c("Modelica"),lty=c(1),col=c("red"))
    if(!combine) {
      dev.off() #flush/close output file
    }
  }
  if(combine) {
    dev.off() #flush/close output file
  }
}

name <- "output/Kotani_full_1000_res_trim.csv"
n <- 1000
#load csv as matrix
data <- as.matrix(read.csv(name))
#subsample: take only n samples
fac <- round(length(data[,1])/n)
data <- data[seq(1,length(data[,1]),fac),]
#call plot function
modelica.plot.all(varnames,data,T)
modelica.plot.all(varnames,data,F)
