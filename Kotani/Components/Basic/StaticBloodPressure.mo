within Kotani.Components.Basic;
model StaticBloodPressure
  parameter Real p = 40;
  Kotani.Components.Basic.BloodVessel bloodVessel1 annotation(Placement(visible = true, transformation(origin = {-80.0,30.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {0.0,-0.0}, extent = {{-100.0,-100.0},{100.0,100.0}}, rotation = 0)));
equation
  bloodVessel1.pressure = p;
  annotation(Diagram(coordinateSystem(extent = {{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5,5})));
end StaticBloodPressure;

