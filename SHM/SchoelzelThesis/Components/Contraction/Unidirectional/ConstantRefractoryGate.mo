within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
model ConstantRefractoryGate "refractory gate with a constant refractory period"
  extends SHM.SchoelzelThesis.Components.Contraction.Unidirectional.RefractoryGate;
  //restrict variability of T_refrac from variable to parameter
  redeclare parameter Real T_refrac = 1 "refractory period";
  annotation(Documentation(info="<html>
    <p>Represents a refractory gate with a constant refractory period.</p>
    <p>This component will let signals pass only if the time since the
    last signal was received is greater than the refractory period.</p>
  </html>"));
end ConstantRefractoryGate;
