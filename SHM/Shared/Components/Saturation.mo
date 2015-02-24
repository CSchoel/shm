within SHM.Shared.Components;
model Saturation "simple saturation function"
  input Real x "unsaturated input";
  parameter Real sat "saturation value";
  parameter Real satexp "saturation exponent (speed of saturation)";
  output Real satx "unsaturated output";
equation
  satx = x + (sat - x) * x ^ satexp / (sat ^ satexp + x ^ satexp);
  annotation(Diagram(coordinateSystem(extent = {{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5,5})));
annotation(Documentation(info="<html><p>Saturation function that allows to control saturation value and saturation speed.</p>
  <p>Gives no hard guarantee about minimum and maximum values. For <b>x << sat</b> output is close to original input. For <b>x >> sat</b> output is close to <b>sat</b>.</p>
</html>"));
end Saturation;

