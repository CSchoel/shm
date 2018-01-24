within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay;
model ConstantConductionDelay
  extends BaseCD;
  parameter Real duration_constant = 1;
equation
  duration = duration_constant;
end ConstantConductionDelay;
