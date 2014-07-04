within Kotani.Components.Basic;
model BloodSystem
  parameter Real initialPressure = 100 "Initial blood pressure";
  Kotani.Components.Basic.BloodVessel vessel annotation(Placement(visible = true, transformation(origin = {-50.955,1.3022}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {-100.0,0.0}, extent = {{-18.0225,-18.0225},{18.0225,18.0225}}, rotation = 0)));
equation
  vessel.rate = der(vessel.pressure);
  annotation(Icon(coordinateSystem(extent = {{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10,10}), graphics = {Ellipse(visible = true, fillColor = {128,0,0}, fillPattern = FillPattern.Solid, extent = {{-82.6823,-83.2796},{82.6823,83.2796}})}), Diagram(coordinateSystem(extent = {{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5,5})));
initial equation
  vessel.pressure = initialPressure;
end BloodSystem;
