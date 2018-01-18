within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay;
model ConstantMultiCD
  extends MultiConductionDelay;
  parameter Real duration_constant = 1;
equation
  duration = duration_constant;
end ConstantMultiCD;
