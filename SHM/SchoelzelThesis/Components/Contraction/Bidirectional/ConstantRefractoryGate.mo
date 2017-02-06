within SHM.SchoelzelThesis.Components.Contraction.Bidirectional;
model ConstantRefractoryGate
  extends SHM.SchoelzelThesis.Components.Contraction.Bidirectional.
          RefractoryGate;
  parameter Real duration = 1;
equation
  T_refrac = duration;
end ConstantRefractoryGate;
