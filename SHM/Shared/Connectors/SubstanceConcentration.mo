within SHM.Shared.Connectors;
connector SubstanceConcentration "SubstanceConcentration"
  Real concentration "concentration of the substance";
  flow Real rate "rate of concentration change";
annotation(Documentation(info="<html>
  <p>This connector models a substance concentration with a unitless concentration and a rate of concentration change. 
  It should be connected to a <b>SHM.Shared.Components.HormoneAmount</b> or <b>SHM.Shared.Components.NeurotransmitterAmount</b> so that the relationship <b>rate = der(pressure)</b> is established.
  </p>"), 
  Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Ellipse(origin = {-41.68, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-40.25, 40.43}, {40.25, -40.43}}, endAngle = 360), Ellipse(origin = {-1.65, 40.75}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-40.25, 40.43}, {40.25, -40.43}}, endAngle = 360), Ellipse(origin = {39.46, -0.07}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-40.25, 40.43}, {40.25, -40.43}}, endAngle = 360), Ellipse(origin = {1.14, -39.82}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-40.25, 40.43}, {40.25, -40.43}}, endAngle = 360)})
);
end SubstanceConcentration;

