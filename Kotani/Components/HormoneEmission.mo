// CP: 65001
// SimulationX Version: 3.6.0.23962 x64
within Kotani.Components;
model HormoneEmission
	extends SubstanceEmission(redeclare Basic.NeurotransmitterConcentration con "SubstanceConcentration");
	equation
		signal = delay(trigger.activation, triggerDelay, triggerDelay) annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
	annotation(
		trigger(activation(flags=2)),
		viewinfo[0](
			viewSettings(clrRaster=12632256),
			typename="ModelInfo"),
		experiment(
			StopTime=1,
			StartTime=0));
end HormoneEmission;
