within Kotani.Examples;
model UnsteadyTestGood
  discrete Real unsteady(start = 0);
  Real testp(start = 0);
  Real testr(start = 0);
  Real progress(start = 0);
  discrete Real tlast(start = 0);
  discrete Real plast(start = 0);
  Real p(start = 0);
equation
  der(p) = 0.5;
  testr = der(testp);
  testr = unsteady * der(progress);
  //testr is a manual differentiation of testp
  //testp = plast + unsteady * progress;
  der(progress) = 2;
  when sample(2, 3) then
    unsteady = time;
    tlast = time;
    plast = p;
    reinit(testp, p + unsteady * progress);
  end when;
  annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
end UnsteadyTestGood;
