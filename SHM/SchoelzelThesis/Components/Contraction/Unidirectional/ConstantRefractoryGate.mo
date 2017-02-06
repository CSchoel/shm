within SHM.SchoelzelThesis.Components.Contraction;
model ConstantRefractoryGate
  extends SHM.SchoelzelThesis.Components.Contraction.RefractoryGate;
  parameter Real duration = 1;
equation
  T_refrac = duration;
end ConstantRefractoryGate;
