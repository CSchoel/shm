within SHM.Shared.Connectors;
connector RespirationOutput "Respiratory phase output"
  output Real phase "Respiratory phase (0-0.5 => expiration, 0.5-1 => inspiration)";
  annotation(Icon(coordinateSystem(extent = {{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10,10}), graphics = {Ellipse(visible = true, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, extent = {{-77.5146,-77.4919},{77.5146,77.4919}})}), Diagram(coordinateSystem(extent = {{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5,5})));
annotation(Documentation(info="<html>
  <p>Models respiratory output as phase that rises from 0 to 1 and is then reset to 0 again (integrate-and-fire).
  The expiration period corresponds to values from 0 to 0.5 and the inspiration period to values from 0.5 to 1.</p>
</html>"));
end RespirationOutput;

