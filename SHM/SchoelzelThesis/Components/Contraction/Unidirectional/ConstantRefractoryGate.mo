within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
model ConstantRefractoryGate "refractory gate with a constant refractory period"
  extends SHM.SchoelzelThesis.Components.Contraction.Unidirectional.RefractoryGate;
  parameter Real duration = 1 "duration of refractory period";
equation
  T_refrac = duration;
  annotation(Documentation(info="<html>
    <p>Represents a refractory gate with a constant refractory period.</p>
    <p>This component will let signals pass only if the time since the
    last signal was received is greater than the refractory period.</p>
  </html>"));
end ConstantRefractoryGate;
