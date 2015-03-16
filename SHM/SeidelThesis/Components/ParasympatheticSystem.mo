within SHM.SeidelThesis.Components;
model ParasympatheticSystem extends SHM.SeidelThesis.Components.ANSPart;
equation
  signal.activation = base_activity + baro_eq + resp_eq;
annotation(Documentation(info="<html>
  <p>Models the parasympathetic system with a base activity, negative baroreceptor influence and positive respiratory influence.</p>
</html>"), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {-0.0025, 78.9025}, extent = {{13.2812, 27.3475}, {51.9531, -46.8787}}, textString = "P")}));
end ParasympatheticSystem;