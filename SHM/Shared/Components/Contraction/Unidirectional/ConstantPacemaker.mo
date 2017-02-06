within SHM.Shared.Components.Contraction;
model ConstantPacemaker
  extends SHM.Shared.Components.Contraction.Pacemaker;
  parameter Real T = 1;
equation
  der(phase) = 1/T;
end ConstantPacemaker;
