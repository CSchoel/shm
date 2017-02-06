within SHM.SchoelzelThesis.Components.Contraction;
model ConstantConductionDelay
  extends SHM.SchoelzelThesis.Components.Contraction.ConductionDelay;
  parameter Real delay_constant = 1;
equation
  delay_time = delay_constant;
end ConstantConductionDelay;
