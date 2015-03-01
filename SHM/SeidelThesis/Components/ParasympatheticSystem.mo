within SHM.SeidelThesis.Components;
model ParasympatheticSystem extends SHM.SeidelThesis.Components.ANSPart;
equation
  signal.activation = base_activity + baro_eq + resp_eq;
annotation(Documentation(info="<html>
  <p>Models the parasympathetic system with a base activity, negative baroreceptor influence and positive respiratory influence.</p>
</html>"));
end ParasympatheticSystem;