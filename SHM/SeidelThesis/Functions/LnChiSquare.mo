within SHM.SeidelThesis.Functions;
function LnChiSquare "logarithmus naturalis of the chi square function (approximated)"
  input Real x "function input";
  input Real n "function index";
  output Real chisq "output";
protected
  Real nh = n/2 "half n, needed in calculation";
algorithm
  chisq := (nh-1) * log(x) - 0.5*x - nh*log(2) -  SHM.SeidelThesis.Functions.LnGamma(nh);
annotation(Documentation(info="<html>
  <p>Approximation of the logarithmus naturalis of the chi squared probability density function.</p>
</html>"));
end LnChiSquare;