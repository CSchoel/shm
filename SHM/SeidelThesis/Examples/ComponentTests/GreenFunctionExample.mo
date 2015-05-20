within SHM.SeidelThesis.Examples.ComponentTests;
model GreenFunctionExample
  Real x "continuous greens function";
  parameter Real[:] gvals = SHM.SeidelThesis.Functions.CreateGreenArray(1,1000,0.15,0.11) "array with Green's function values";
equation
  x = SHM.SeidelThesis.Functions.GreensFunction(time,0.15,0.11);
annotation(Documentation(info="<html>
  <p>Test model for the Green's function that shows both an array generated with CreateGreenArray and the application of a Green's function to t.</p>
  <p style=\"color:red;\">This model does not have graphical annotations. It is only designed for testing the component.</p>
</html>"));
end GreenFunctionExample;