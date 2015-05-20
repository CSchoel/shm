within SHM.SeidelThesis.Components;
model Broaden "broadening function"
  input Real x "unbroadened input";
  parameter Real len = 1 "broadening length in seconds";
  parameter Real resolution = 1000 "calculation steps per second";
  parameter Real eta = 0.15 "eta";
  parameter Real sigma = 0.11 "sigma";
  parameter Real[n] gvals = SHM.SeidelThesis.Functions.CreateGreenArray(len,resolution,eta,sigma) "green's function values";
  output Real xbroad "broadened output";
  Real history[n] "history needed for broadening";
protected
  parameter Integer n = integer(ceil(len*resolution)) "length of arrays";
  parameter Real stepsize = 1/resolution "step size";
equation
  for i in 1:size(history,1) loop
    history[i] = delay(x,(i-1)*stepsize,(i-1)*stepsize);
  end for;
  //xbroad = x;
  xbroad = (history * gvals) * stepsize;
annotation(Documentation(info="<html>
  <p>Models a broadening function (convolution of input with precalculated values of Green's function).</p>
  <p style=\"color:red;\">Warning: Translation and simulation will be very slow for large values of len and/or resolution.</p>
</html>"));
end Broaden;