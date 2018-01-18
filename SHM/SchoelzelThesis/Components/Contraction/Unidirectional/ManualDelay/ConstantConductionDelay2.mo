within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay;
model ConstantConductionDelay2
  extends ConductionDelay2(redeclare replaceable ConductionDelay strategy);
  parameter Real duration_constant = 1;
equation
  duration = duration_constant;
end ConstantConductionDelay2;
