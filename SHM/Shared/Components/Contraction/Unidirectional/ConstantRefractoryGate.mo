within SHM.Shared.Components.Contraction;
model ConstantRefractoryGate
  extends SHM.Shared.Components.Contraction.RefractoryGate;
  parameter Real duration = 1;
equation
  T_refrac = duration;
end ConstantRefractoryGate;
