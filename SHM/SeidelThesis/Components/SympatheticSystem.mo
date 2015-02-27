within SHM.SeidelThesis.Components;
class SympatheticSystem extends SHM.SeidelThesis.Components.ANSPart;
equation
  signal.activation = base_activity + baro_eq + resp_eq;
annotation(Documentation(info="<html>
  <p>Models the sympathetic system with a base activity, positive baroreceptor influence and positive respiratory influence.</p>
</html>"));
end SympatheticSystem;