within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
model ConstantConductionDelay
  extends SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ConductionDelay;
  parameter Real delay_constant = 1;
equation
  delay_time = delay_constant;
end ConstantConductionDelay;
