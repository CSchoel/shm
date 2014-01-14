within Kotani.Components;
model HormoneEmission
  extends Kotani.Components.SubstanceEmission;
  parameter Real baseSignal = 0;
  Kotani.Components.Basic.HormoneConcentration hormone annotation(Placement(visible = true, transformation(origin = {-6.79785,-97.3166}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-1.78891,6.44007}, extent = {{-88.0143,-88.0143},{88.0143,88.0143}}, rotation = 0)));
equation
  hormone.concentration = con;
  signal = delay(trigger.activation + baseSignal, triggerDelay, triggerDelay) annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
end HormoneEmission;

