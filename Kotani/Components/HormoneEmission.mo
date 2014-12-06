within Kotani.Components;
model HormoneEmission "Emits hormones based on a neural signal"
  extends SubstanceEmission(triggerDelay = 4.2, prodFac = 0.5, Tuptake = 2);
  parameter Real baseSignal = 0.2;
  //trigger and con are manual redeclarations of the superclass components (needed to make annotations visible in OpenModelica)
  Basic.NerveInput trigger annotation(Placement(visible = true, transformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Basic.HormoneConcentration con annotation(Placement(visible = true, transformation(origin = {40, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {40, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  signal = delay(trigger.activation + baseSignal, triggerDelay, triggerDelay) annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
end HormoneEmission;