within Kotani.Examples;
model DynamicExample
  Real temp(start = 0);
  Boolean cool(start = false);
  Real temp_heat(start = 0);
  Real temp_cool(start = 0);
equation
  temp_heat = time * time + 4;
  der(temp_cool) = -temp_cool * 0.3;
  temp = if cool then temp_cool else temp_heat;
  when time > 5 then
    cool = true;
    reinit(temp_cool, temp_heat);
  end when;
  annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
end DynamicExample;