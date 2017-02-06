within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
model ConstantRefractoryGate
  extends SHM.SchoelzelThesis.Components.Contraction.Unidirectional.RefractoryGate;
  parameter Real duration = 1;
equation
  T_refrac = duration;
end ConstantRefractoryGate;
