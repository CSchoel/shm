within Kotani.Components;
model ParasympatheticSystem
  Kotani.Components.Basic.RespirationInput resp annotation(Placement(visible = true, transformation(origin = {17.8036,4.7749}, extent = {{-14.85,-10.5},{14.85,10.5}}, rotation = 0), iconTransformation(origin = {0.0,100.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
  Kotani.Components.Basic.NerveInput baro annotation(Placement(visible = true, transformation(origin = {-148.5677,35.5947}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {-100.0,0.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
  Kotani.Components.Basic.NerveOutput signal annotation(Placement(visible = true, transformation(origin = {0.0,-104.6138}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {-0.0,-100.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
  parameter Real baro_influence = 0.036;
  parameter Real resp_influence = 0.0045;
  parameter Real v0 = 0;
  parameter Real scaling_factor = 1.1;
equation
  signal.activation = max(0, scaling_factor * (v0 + baro_influence * baro.activation + resp_influence * (1 - resp.phase)));
  annotation(Icon(coordinateSystem(extent = {{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10,10}), graphics = {Ellipse(visible = true, fillColor = {255,255,255}, extent = {{-85.0,-85.0},{85.0,85.0}}),Text(visible = true, origin = {5.5828,-3.6597}, fillPattern = FillPattern.Solid, extent = {{-64.4172,-73.6597},{64.4172,73.6597}}, textString = "P", fontName = "Arial"),Polygon(visible = true, origin = {-91.5481,19.7806}, fillColor = {128,0,0}, fillPattern = FillPattern.Solid, points = {{-3.305,1.254},{-5.794,-1.633},{-5.794,-7.905},{-2.355,-11.29},{3.069,-11.29},{5.98,-7.905},{6.088,-1.789},{3.177,1.783},{2.119,8.398},{-0.28,14.904},{-1.188,9.72},{-1.718,5.752}}, smooth = Smooth.Bezier),Line(visible = true, origin = {26.4142,-94.2358}, points = {{-14.508,-4.718},{-6.306,6.394},{-3.66,-7.1},{4.013,8.511},{6.13,-8.423},{14.332,5.336}}, thickness = 3)}), Diagram(coordinateSystem(extent = {{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5,5})));
end ParasympatheticSystem;

