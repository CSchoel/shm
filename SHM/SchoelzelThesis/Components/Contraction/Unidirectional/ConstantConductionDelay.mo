within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
model ConstantConductionDelay
  extends SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ConductionDelay;
  parameter Real duration_constant = 1;
equation
  duration = duration_constant;
end ConstantConductionDelay;
