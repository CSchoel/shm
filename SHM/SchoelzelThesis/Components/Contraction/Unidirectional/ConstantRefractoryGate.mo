within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
model ConstantRefractoryGate
  extends SHM.SchoelzelThesis.Components.Contraction.Unidirectional.RefractoryGate;
  //restrict variability of T_refrac from variable to parameter
  redeclare parameter Real T_refrac = 1;
end ConstantRefractoryGate;
