within Kotani.Examples;
model SatSignalExample
  Real r;
  Kotani.Components.Basic.TestSatSignal testSatSignal1 annotation(Placement(visible = true, transformation(origin = {-80.0,20.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
  Kotani.Components.Basic.NerveSystem nerveSystem1 annotation(Placement(visible = true, transformation(origin = {-35.0,20.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
equation
  connect(testSatSignal1.no,nerveSystem1.fiber) annotation(Line(points = {{-70,20.2894},{-36.0644,20.2894},{-36.0644,19.5349},{-36.0644,19.5349}}));
  r = Kotani.Functions.Sat(time, 2, 2);
  annotation(Diagram(coordinateSystem(extent = {{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5,5})));
end SatSignalExample;

