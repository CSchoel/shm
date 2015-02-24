within SHM.Shared.Connectors;
connector NeurotransmitterConcentration "Postsynaptic concentration of a neurotransmitter"
  extends SHM.Shared.Connectors.SubstanceConcentration;
  annotation(Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Rectangle(origin = {1.43113,-0.178891}, fillColor = {170,85,255}, fillPattern = FillPattern.Solid, extent = {{-77.2809,74.2397},{77.2809,-74.2397}}),Rectangle(origin = {-3.6136,-8.80143}, rotation = 45, fillColor = {170,85,255}, fillPattern = FillPattern.Solid, extent = {{-64.8844,72.9748},{81.0757,-65.3851}})}));
annotation(Documentation(info="<html><p>Same as <b>SHM.Shared.Connectors.SubstanceConcentration</b> with different icon.</p></html>"));
end NeurotransmitterConcentration;

