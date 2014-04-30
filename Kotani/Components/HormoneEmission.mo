within Kotani.Components;
model HormoneEmission "Emits hormones based on a neural signal"
  extends SubstanceEmission(triggerDelay = 4.2, prodFac = 0.5, Tuptake = 2, redeclare Basic.HormoneConcentration con "SubstanceConcentration");
  parameter Real baseSignal = 0.2;
equation
  signal = delay(trigger.activation + baseSignal, triggerDelay, triggerDelay) annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
end HormoneEmission;
