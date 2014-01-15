// CP: 65001
// SimulationX Version: 3.6.0.23962 x64
within Kotani.Components;
model NeurotransmitterEmission
	extends SubstanceEmission(redeclare Basic.HormoneConcentration con "SubstanceConcentration");
	parameter Real baseSignal=0;
	equation
		signal = delay(trigger.activation + baseSignal, triggerDelay, triggerDelay) annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
	annotation(
		trigger(activation(flags=2)),
		experiment(
			StopTime=1,
			StartTime=0));
end NeurotransmitterEmission;
