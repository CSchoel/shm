within SHM.SeidelThesis.Examples.ComponentTests;
model BroadeningExample "test model for broadening function"
  SHM.SeidelThesis.Components.Broaden broad(resolution=100) "broadening component";
  Real x(start = 10,fixed=true) "input value";
  Real xbroad "broadened version of x";
equation
  der(x) = if time >= 1 and time <= 2 then 100 else 0;
  broad.x = x;
  broad.xbroad = xbroad;
annotation(Documentation(info="<html>
  <p>Test model for broadening component that shows the broadening of a ramp function.</p>
  <p style=\"color:red;\">This model does not have graphical annotations. It is only designed for testing the component.</p>
</html>"));
end BroadeningExample;