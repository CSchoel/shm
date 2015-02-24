within SHM.SeidelThesis.Functions;
function LnGamma "logarithmus naturalis of the gamma function (approximated)"
  input Real x "input";
  output Real lngamma "output";
protected
  Real coefficients[6] = {76.18009172947146,-86.50532032941677,
	24.01409824083091,-1.231739572450155,
	0.1208650973866179e-2,-0.5395239384953e-5} "coefficients of Lanczos approximation (probably?)";
  Real tmp "temporary value";
  Real ser "sum";
  Real y "counter";
algorithm
  //Implementation directly taken from Seidels Implementation in C
  y := x;
  tmp := x + 5.5;
  tmp := tmp - (x+0.5)*log(tmp);
  ser := 1.000000000190015;
  for j in 1:6 loop
    y := y + 1;
    ser := ser+ coefficients[j]/y;
  end for;
  lngamma := -tmp + log(2.5066282746310005*ser/x);
annotation(Documentation(info="<html>
  <p>Calculates the logarithmus naturalis of the gamma function with a Lanczos approximation.</p>
  <p>This code is translated from C-Code by Dr. Henrik Seidel where it is attributed as follows :</p>
  <pre>(C) Copr. 1986-92 Numerical Recipes Software 5$1L$]...</pre>
</html>"));
end LnGamma;