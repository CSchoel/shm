within Kotani.Components;
model NeurotransmitterEmission "Emits a neurotransmitter based on a neural signal"
  extends SubstanceEmission(redeclare Basic.NeurotransmitterConcentration con "SubstanceConcentration");
equation
  signal = delay(trigger.activation, triggerDelay, triggerDelay) annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
  annotation(trigger(activation(flags = 2)), experiment(StopTime = 1, StartTime = 0));
end NeurotransmitterEmission;

