within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay;
model ConstantConductionDelay "conduction delay with constant duration"
  extends BaseCD;
  parameter Real duration_constant = 1 "duration of the delay";
equation
  duration = duration_constant;
  annotation(Documentation(info="<html>
    <p>Represents a constant conduction delay that does not change for
    the duration of the simulation.</p>
  </html>"));
end ConstantConductionDelay;
