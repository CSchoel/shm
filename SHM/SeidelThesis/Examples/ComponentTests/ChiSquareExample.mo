within SHM.SeidelThesis.Examples.ComponentTests;
model ChiSquareExample
  Real x;
  Real y;
equation
  x = exp(SHM.SeidelThesis.Functions.LnChiSquare(time,3));
  y = exp(SHM.SeidelThesis.Functions.LnGamma(time));
end ChiSquareExample;