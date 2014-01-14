within Kotani.Components;
model SubstanceEmission
  parameter Real Tuptake = 0 "time for total uptake of substance";
  parameter Real prodFac = 1 "production factor";
  parameter Real triggerDelay = 0 "delay until release of substance is triggered";
  Kotani.Components.Basic.Nerve trigger annotation(Placement(visible = true, transformation(origin = {-2.86225,99.1055}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-3.22004,99.1055}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Real con;
protected
  Real signal;
equation
  der(con) = -con / TUptake + prodFac * signal;
  annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
end SubstanceEmission;

