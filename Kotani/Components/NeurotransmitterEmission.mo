within Kotani.Components;
model NeurotransmitterEmission "Emits a neurotransmitter based on a neural signal"
  extends SubstanceEmission(triggerDelay = 1.65, prodFac = 0.7, Tuptake = 2);
  redeclare Basic.NerveInput trigger annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  redeclare Basic.NeurotransmitterConcentration con "SubstanceConcentration" annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  signal = delay(trigger.activation, triggerDelay, triggerDelay) annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
end NeurotransmitterEmission;