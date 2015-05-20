within SHM.SeidelThesis.Examples.ComponentTests;
model ChiSquareExample "test model for the implementation of the chi squared probability density function"
  Real x "chi squared";
  Real y "gamma function";
equation
  x = exp(SHM.SeidelThesis.Functions.LnChiSquare(time,3));
  y = exp(SHM.SeidelThesis.Functions.LnGamma(time));
annotation(Documentation(info="<html>
  <p>Test model for the implementation of the chi square PDF and the gamma function showing the raw functions applied to t.</p>
  <p style=\"color:red;\">This model does not have graphical annotations. It is only designed for testing the component.</p>
</html>"));

end ChiSquareExample;