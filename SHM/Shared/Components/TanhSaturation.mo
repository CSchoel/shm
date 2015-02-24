within SHM.Shared.Components;
model TanhSaturation "Saturation function using tanh"
  input Real x "unsaturated input";
  output Real satx "saturated output";
  parameter Real sat_speed = 1 "Saturation speed (multiplier)";
  parameter Real max_val = 1 "Saturation value that will not be exceeded";
  parameter Real inflection_x = 0.5 "Point of inflection on the x-Axis";
equation
  satx = max_val / 2 * (1 + tanh(sat_speed * (x - inflection_x)));
annotation(Diagram(coordinateSystem(extent = {{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5,5})));
annotation(Documentation(info="<html><p>Saturation function that allows to control max value, saturation speed and point of inflection.</p>
  <p>Values are guaranteed to lie between 0 and <b>max_val</b>.</p>
</html>"));
end TanhSaturation;

