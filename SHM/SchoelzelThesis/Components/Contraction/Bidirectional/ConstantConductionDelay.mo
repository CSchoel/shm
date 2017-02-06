within SHM.SchoelzelThesis.Components.Contraction.Bidirectional;
model ConstantConductionDelay
  extends SHM.SchoelzelThesis.Components.Contraction.Bidirectional.
          ConductionDelay;
  parameter Real delay_constant = 1;
equation
  delay_time = delay_constant;
end ConstantConductionDelay;
