within Kotani.Examples;
model IntegrateAndFireExample
  Real x(start = 0);
  Real dx(start = 0);
  Boolean state(start = true);
equation
  der(x) = dx;
  der(dx) = 1;
  when x > 1 then
    reinit(x, 0);
    state = not pre(state);
  end when;
  annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
end IntegrateAndFireExample;