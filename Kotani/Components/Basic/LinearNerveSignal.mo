within Kotani.Components.Basic;
model LinearNerveSignal
  parameter Real t1 = 0;
  parameter Real t2 = 1;
  parameter Real baseval = 0;
  parameter Real topval = 0;
  Kotani.Components.Basic.NerveOutput nerve1 annotation(Placement(visible = true, transformation(origin = {148.2445,1.5564}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {0.0,-0.0}, extent = {{-47.2263,-47.2263},{47.2263,47.2263}}, rotation = 0)));
protected
  Real rate = baseval/(t2-t1);
equation
  if time < t1 then
    nerve1.activation = baseval;
  elseif time > t2 then
    nerve1.activation = topval;
  else
    nerve1.activation = baseval + (time-t1)*rate;
  end if;
  annotation(Icon(coordinateSystem(extent = {{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10,10}), graphics = {Line(visible = true, origin = {3.3073,-7.0003}, points = {{-103.307,-67.0},{-58.291,-67.0},{64.906,67.0},{96.693,67.0}}, thickness = 1)}), Diagram(coordinateSystem(extent = {{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5,5})));
end LinearNerveSignal;

