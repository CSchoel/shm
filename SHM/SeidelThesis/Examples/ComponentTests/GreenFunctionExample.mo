within SHM.SeidelThesis.Examples.ComponentTests;
model GreenFunctionExample
  Real x;
equation
  x = SHM.SeidelThesis.Functions.GreensFunction(time,0.15,0.11);
end GreenFunctionExample;