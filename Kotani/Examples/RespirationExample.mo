within Kotani.Examples;

model RespirationExample
  Kotani.Components.SimpleLung simpleLung1 annotation(Placement(visible = true, transformation(origin = {0.0, 72.3713}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
  Kotani.Components.Basic.LinearNerveSignal linearnervesignal1(t1 = 3, t2 = 4, topval = 2) annotation(Placement(visible = true, transformation(origin = {-81.2903, 39.01}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(linearnervesignal1.nerve1, simpleLung1.baro) annotation(Line(points = {{-81.2903, 39.01}, {-46.0178, 39.01}, {-46.0178, 65.1724}, {-46.0178, 65.1724}}));
  annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = false, initialScale = 0.1, grid = {5, 5}), graphics));
end RespirationExample;
