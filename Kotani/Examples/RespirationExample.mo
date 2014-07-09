within Kotani.Examples;

model RespirationExample
  Kotani.Components.Basic.NerveSystem nerveSystem2 annotation(Placement(visible = true, transformation(origin = {-45.0, 65.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
  Kotani.Components.SimpleLung simpleLung1 annotation(Placement(visible = true, transformation(origin = {0.0, 72.3713}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
  Kotani.Components.Basic.RespiratorySystem respiratorySystem1 annotation(Placement(visible = true, transformation(origin = {26.9455, 50.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
  Kotani.Components.Basic.LinearNerveSignal linearnervesignal1(t1 = 3, t2 = 4, rate = 2) annotation(Placement(visible = true, transformation(origin = {-81.2903, 39.01}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(simpleLung1.resp, respiratorySystem1.phase) annotation(Line(points = {{0, 62.5884}, {16.5851, 62.5884}, {16.5851, 50.4561}, {16.5851, 50.4561}}));
  connect(nerveSystem2.fiber, simpleLung1.baro) annotation(Line(points = {{-46, 65}, {-10.5117, 65}, {-10.5117, 71.9466}, {-10.5117, 71.9466}}));
  connect(linearnervesignal1.nerve1, nerveSystem2.fiber) annotation(Line(points = {{-81.2903, 39.01}, {-46.0178, 39.01}, {-46.0178, 65.1724}, {-46.0178, 65.1724}}));
  annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = false, initialScale = 0.1, grid = {5, 5}), graphics));
end RespirationExample;
