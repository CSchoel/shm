within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay;
model ConstantConductionDelay "conduction delay with constant duration"
  extends BaseCD;
  // reduce variability of duration from variable to parameter
  redeclare parameter Real duration = 1 "duration of the delay";
  annotation(Documentation(info="<html>
    <p>Represents a constant conduction delay that does not change for
    the duration of the simulation.</p>
  </html>"));
end ConstantConductionDelay;
