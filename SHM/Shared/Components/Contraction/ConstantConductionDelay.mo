within SHM.Shared.Components.Contraction;
model ConstantConductionDelay
  extends SHM.Shared.Components.Contraction.ConductionDelay;
  parameter Real delayConstant = 1;
equation
  delayTime = delayConstant;
end ConstantConductionDelay;
