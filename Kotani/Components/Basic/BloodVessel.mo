within Kotani.Components.Basic;
connector BloodVessel "Blood vessel propagating blood pressure"
  Real pressure "blood pressure p";
  flow Real rate "rate of blood pressure dp/dt";
  annotation(Icon(coordinateSystem(extent = {{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10,10}), graphics = {Rectangle(visible = true, origin = {-0.0,-0.2067}, fillColor = {128,0,0}, fillPattern = FillPattern.Solid, extent = {{-100.0,-27.0785},{100.0,27.0785}})}));
end BloodVessel;

