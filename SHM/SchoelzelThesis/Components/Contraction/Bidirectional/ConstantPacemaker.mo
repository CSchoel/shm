within SHM.SchoelzelThesis.Components.Contraction.Bidirectional;
model ConstantPacemaker
  extends SHM.SchoelzelThesis.Components.Contraction.Bidirectional.Pacemaker;
  parameter Real T = 1;
equation
  der(phase) = 1/T;
end ConstantPacemaker;
