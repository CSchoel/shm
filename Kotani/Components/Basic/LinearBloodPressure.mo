within Kotani.Components.Basic;
model LinearBloodPressure
  parameter Real t1 = 0;
  parameter Real t2 = 1;
  parameter Real rate = 100;
  Kotani.Components.Basic.BloodVessel vessel annotation(Placement(visible = true, transformation(origin = {-73.1495,-5.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {0.0,-0.0}, extent = {{-100.0,-100.0},{100.0,100.0}}, rotation = 0)));
equation
  vessel.rate = if time >= t1 and time < t2 then -rate else 0;
  annotation(Icon(coordinateSystem(extent = {{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10,10}), graphics = {Line(visible = true, origin = {-1.047,3.826}, points = {{-98.953,-76.174},{-58.953,-76.174},{56.858,76.174},{101.047,76.174}}, thickness = 1)}), Diagram(coordinateSystem(extent = {{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5,5})));
end LinearBloodPressure;
