within SHM.Shared.Components.Compartments;
model HormoneAmount "hormone amount in a closed blood system"
  parameter Real initialConcentration = 0 "Initial hormone concentration";
  SHM.Shared.Connectors.HormoneConcentration con "hormone concentration connector" annotation(Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  con.rate = der(con.concentration);
initial equation
  con.concentration = initialConcentration;
annotation(Documentation(info="<html>
  <p>Models concentration of a hormone substance in a closed blood system.</p>
</html>"), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Ellipse(origin = {-67.6189, 48.302}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-15, 15}, {15, -15}}, endAngle = 360), Ellipse(origin = {6.04839, 38.2483}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-15, 15}, {15, -15}}, endAngle = 360), Ellipse(origin = {40.0019, 65.404}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-15, 15}, {15, -15}}, endAngle = 360), Ellipse(origin = {-18.3165, -18.6748}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-15, 15}, {15, -15}}, endAngle = 360), Ellipse(origin = {-46.2235, 16.0301}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-15, 15}, {15, -15}}, endAngle = 360), Ellipse(origin = {35.6727, -17.2794}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-15, 15}, {15, -15}}, endAngle = 360), Ellipse(origin = {52.5242, 27.1213}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-15, 15}, {15, -15}}, endAngle = 360), Ellipse(origin = {-25.5079, 69.6616}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-15, 15}, {15, -15}}, endAngle = 360), Ellipse(origin = {-5.54562, 28.2648}, extent = {{-92.8444, 70.1252}, {104.293, -74.4186}}, endAngle = 360), Text(origin = {0.18, -67.8}, extent = {{-99.64, 26.2933}, {99.64, -31.66}}, textString = "%name")}));
end HormoneAmount;

