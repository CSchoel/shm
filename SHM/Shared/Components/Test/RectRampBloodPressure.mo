within SHM.Shared.Components.Test;
model RectRampBloodPressure "blood pressure source that has a rising and falling ramp"
  parameter Real t1 = 1 "rising ramp start";
  parameter Real t2 = 2 "rising ramp end";
  parameter Real t3 = 3 "falling ramp start";
  parameter Real t4 = 4 "falling ramp end";
  parameter Real h = 100 "height of ramp";
  SHM.Shared.Connectors.BloodVessel vessel "blood vessel that is affected by this signal" annotation(Placement(visible = true, transformation(origin = {-73.1495,-5.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {0.0,-0.0}, extent = {{-100.0,-100.0},{100.0,100.0}}, rotation = 0)));
protected 
  Real rise_rate = h/(t2-t1) "rising slope";
  Real fall_rate = -h/(t4-t3) "falling slope";
equation
  if time >= t1 and time <= t2 then
    vessel.rate = -rise_rate;
  elseif time >= t3 and time <= t4 then
    vessel.rate = -fall_rate;
  else
    vessel.rate = 0;
  end if;
  annotation(Icon(coordinateSystem(extent = {{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10,10}), graphics = {Line(visible = true, origin = {-1.047,3.826}, points = {{-98.953,-76.174},{-58.953,-76.174},{56.858,76.174},{101.047,76.174}}, thickness = 1)}), Diagram(coordinateSystem(extent = {{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5,5})));
annotation(Documentation(info="<html>
  <p>Generates a trapezoidal blood pressure wave with a rising and falling ramp.</p>
</html>"));
end RectRampBloodPressure;
