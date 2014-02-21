within Kotani.Examples;
model DiscreteSignalExample
  discrete Real s(start = 0);
  discrete Real tlast(start = 0);
  Real iv(start = 0);
  Real x(start = -0.1);
  Boolean cond(start = false);
  Boolean cond2(start = true);
  Boolean fin(start = false);
  Real one(start = 1);
equation
  one = 1;
  der(iv) = 0.4;
  der(x) = 1;
  s = if x > 0 then 0 else 1;
  when x > iv then
      reinit(x, 0);
    tlast = time;
    cond = not pre(cond);
  
  end when;
  fin = change(cond);
  when fin then
      cond2 = not pre(cond2);
  
  end when;
  annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), experiment(StartTime = 0, StopTime = 10, Tolerance = 0.000001));
end DiscreteSignalExample;

