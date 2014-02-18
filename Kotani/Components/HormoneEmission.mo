within Kotani.Components;
model HormoneEmission "Emits hormones based on a neural signal"
  extends SubstanceEmission(redeclare Basic.HormoneConcentration con "SubstanceConcentration");
  parameter Real baseSignal = 0;
equation
  signal = delay(trigger.activation + baseSignal, triggerDelay, triggerDelay) annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
end HormoneEmission;

