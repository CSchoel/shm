within Kotani.Components.Basic;
model TSaturation "Saturation function that allows to control max value, saturation speed and point of inflection"
  input Real x "Input";
  output Real satx "Output";
  parameter Real sat_speed = 1 "Saturation speed (multiplier)";
  parameter Real max_val = 1 "Saturation value that will not be exceeded";
  parameter Real inflection_x = 0.5 "Point of inflection on the x-Axis";
equation
  satx = max_val / 2 * (1 + tanh(sat_speed * (x - inflection_x)));
annotation(Diagram(coordinateSystem(extent = {{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5,5})));
end TSaturation;

