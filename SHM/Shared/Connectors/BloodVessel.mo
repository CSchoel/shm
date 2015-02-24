within SHM.Shared.Connectors;
connector BloodVessel "Blood vessel propagating blood pressure"
  Real pressure "blood pressure p";
  flow Real rate "rate of blood pressure dp/dt";
  annotation(Icon(coordinateSystem(extent = {{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10,10}), graphics = {Rectangle(visible = true, origin = {-0.0,-0.2067}, fillColor = {128,0,0}, fillPattern = FillPattern.Solid, extent = {{-100.0,-27.0785},{100.0,27.0785}})}));
annotation(Documentation(info="<html>
  <p>This connector models a blood vessel with a pressure in mmHg and a rate of pressure change. 
  It should be connected to a <a href=\"modelica://SHM.Shared.Components.BloodSystem\">SHM.Shared.Components.BloodSystem</a> so that the relationship <b>rate = der(pressure)</b> is established.
  </p>"
));
end BloodVessel;
