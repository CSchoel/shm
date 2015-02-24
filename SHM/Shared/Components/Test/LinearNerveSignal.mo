within SHM.Shared.Components.Test;
model LinearNerveSignal "Linear rising nerve signal"
  parameter Real t1 = 0 "starting time of ramp";
  parameter Real t2 = 1 "end time of ramp";
  parameter Real baseval = 0 "base value before ramp";
  parameter Real topval = 0 "value after ramp";
  SHM.Shared.Connectors.NerveOutput nerve1 "nerve fiber" annotation(Placement(visible = true, transformation(origin = {148.2445,1.5564}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {0.0,-0.0}, extent = {{-47.2263,-47.2263},{47.2263,47.2263}}, rotation = 0)));
protected
  Real rate = baseval/(t2-t1) "slope of ramp";
equation
  if time < t1 then
    nerve1.activation = baseval;
  elseif time > t2 then
    nerve1.activation = topval;
  else
    nerve1.activation = baseval + (time-t1)*rate;
  end if;
  annotation(Icon(coordinateSystem(extent = {{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10,10}), graphics = {Line(visible = true, origin = {3.3073,-7.0003}, points = {{-103.307,-67.0},{-58.291,-67.0},{64.906,67.0},{96.693,67.0}}, thickness = 1)}), Diagram(coordinateSystem(extent = {{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5,5})));
annotation(Documentation(info="<html>
  <p>Generates a linear rising nerve signal as a ramp starting at <b>t1</b> with value <b>baseval</b> and ending at <b>t2</b> with value <b>topval</b>.</p>
</html>"));
end LinearNerveSignal;

