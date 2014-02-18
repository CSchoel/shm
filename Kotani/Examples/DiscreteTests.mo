within Kotani.Examples;
model DiscreteTests
  Real v(start = 0);
  discrete Real p(start = 0);
  Real cp(start = 0);
  Real step(start = 0);
  Real cstep(start = 0);
equation
  der(v) = 1;
  //step = 0;
  p = if sample(0, 1) then 1 else 0;
  cp = if sample(0, 1) then 1 else 0;
  when p >= 1 then
      step = time;
  
  end when;
  when cp >= 1 then
      cstep = time;
  
  end when;
  annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
end DiscreteTests;

