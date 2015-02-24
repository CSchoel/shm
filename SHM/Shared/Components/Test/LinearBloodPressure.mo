within SHM.Shared.Components.Test;
model LinearBloodPressure "Linear rising blood pressure"
  parameter Real t1 = 0 "starting time of ramp";
  parameter Real t2 = 1 "end time of ramp";
  parameter Real rate = 100 "ramp steepness";
  SHM.Shared.Connectors.BloodVessel vessel "blood vessel" annotation(Placement(visible = true, transformation(origin = {-73.1495,-5.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {0.0,-0.0}, extent = {{-100.0,-100.0},{100.0,100.0}}, rotation = 0)));
equation
  vessel.rate = if time >= t1 and time < t2 then -rate else 0;
  annotation(Icon(coordinateSystem(extent = {{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10,10}), graphics = {Line(visible = true, origin = {-1.047,3.826}, points = {{-98.953,-76.174},{-58.953,-76.174},{56.858,76.174},{101.047,76.174}}, thickness = 1)}), Diagram(coordinateSystem(extent = {{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5,5})));
annotation(Documentation(info="<html>
  <p>Generates a linear rising blood pressure as a ramp starting at <b>t1</b> and ending at <b>t2</b> with a fixed rate <b>rate</b>.</p>
</html>"));
end LinearBloodPressure;
