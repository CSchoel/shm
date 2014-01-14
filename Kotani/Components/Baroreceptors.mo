within Kotani.Components;
model Baroreceptors "Baroreceptors measuring blood pressure"
  parameter Real p0 = 50 "minimum blood pressure needed to generate signal";
  parameter Real k1 = 0.02 "sensitivity of baroreceptors to blood pressure level";
  parameter Real k2 = 0.00125 "sensitivity of baroreceptors to change in blood pressure";
  Kotani.Components.Basic.BloodVessel artery annotation(Placement(visible = true, transformation(origin = {-3.0696,0.4341}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {-0.0,0.0}, extent = {{-100.0,-100.0},{100.0,100.0}}, rotation = 0)));
  Kotani.Components.Basic.Nerve signal annotation(Placement(visible = true, transformation(origin = {-1.8417,85.0801}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {0.0,100.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
equation
  signal.activation = (artery.pressure - p0) * k1 + artery.rate * k2;
  annotation(Icon(coordinateSystem(extent = {{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10,10}), graphics = {Text(visible = true, origin = {-0.0,-73.1144}, fillPattern = FillPattern.Solid, extent = {{-100.0,-26.8856},{100.0,26.8856}}, textString = "%name", fontName = "Arial")}), Diagram(coordinateSystem(extent = {{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5,5})));
end Baroreceptors;

