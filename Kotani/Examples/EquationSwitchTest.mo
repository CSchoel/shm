within Kotani.Examples;
model EquationSwitchTest
  Real test(start = 50);
  Real x(start = 0);
  Real test2(start = 50);
  Real test2_1(start = 50);
  Real test2_2(start = 50);
  Boolean switch = x > 0.2;
equation
  der(x) = 0.1;
  test2_1 = 10 + x;
  der(test2_2) = -1;
  test2 = if switch then test2_1 else test2_2;
  //Not needed
  when switch then
    reinit(test2_1, test2);
  end when;
  test = 1;
  //if switch then
  //  test = 10 + x;
  //else
  //  der(test) = -1;
  //end if;
  annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
end EquationSwitchTest;
