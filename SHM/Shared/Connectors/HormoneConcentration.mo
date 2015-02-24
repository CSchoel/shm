within SHM.Shared.Connectors;
connector HormoneConcentration "Concentration of a hormone in the blood vessels"
  extends SHM.Shared.Connectors.SubstanceConcentration;
  annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Ellipse(origin = {-41.68, 0}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-40.25, 40.43}, {40.25, -40.43}}, endAngle = 360), Ellipse(origin = {-1.65, 40.75}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-40.25, 40.43}, {40.25, -40.43}}, endAngle = 360), Ellipse(origin = {39.46, -0.07}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-40.25, 40.43}, {40.25, -40.43}}, endAngle = 360), Ellipse(origin = {1.14, -39.82}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-40.25, 40.43}, {40.25, -40.43}}, endAngle = 360)}));
annotation(Documentation(info="<html><p>Same as <b>SHM.Shared.Connectors.SubstanceConcentration</b> with different icon.</p></html>"));
end HormoneConcentration;

