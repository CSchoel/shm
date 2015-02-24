within SHM.Kotani2005.Examples.ComponentTests;
model RespirationExample "lung test"
  SHM.Kotani2005.Components.SimpleLung simpleLung1 "lung model" annotation(Placement(visible = true, transformation(origin = {0.0, 72.3713}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
  SHM.Shared.Components.Test.LinearNerveSignal linearnervesignal1(t1 = 3, t2 = 4, topval = 2) "nerve test input" annotation(Placement(visible = true, transformation(origin = {-81.2903, 39.01}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(linearnervesignal1.nerve1, simpleLung1.baro) annotation(Line(points = {{-81.2903, 39.01}, {-46.0178, 39.01}, {-46.0178, 65.1724}, {-46.0178, 65.1724}}));
  annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = false, initialScale = 0.1, grid = {5, 5}), graphics));
annotation(Documentation(info="<html>
  Models a simple test system with a lung and a synthetic baroreceptor input.
</html>"));
end RespirationExample;
