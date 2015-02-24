within SHM.SeidelThesis.Examples.ComponentTests;
model GreenFunctionExample
  Real x;
  parameter Real[:] gvals = SHM.SeidelThesis.Functions.CreateGreenArray(1,1000,0.15,0.11);
equation
  x = SHM.SeidelThesis.Functions.GreensFunction(time,0.15,0.11);
end GreenFunctionExample;