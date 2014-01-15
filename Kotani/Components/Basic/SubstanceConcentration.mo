// CP: 65001
// SimulationX Version: 3.6.0.23962 x64
within Kotani.Components.Basic;
connector SubstanceConcentration "SubstanceConcentration"
	Real concentration;
	Real rate;
	annotation(Icon(graphics={
			Ellipse(
				lineColor={0,0,0},
				fillColor={255,255,255},
				fillPattern=FillPattern.Solid,
				extent={{-60,50},{73.3,-76.7}})}));
end SubstanceConcentration;
