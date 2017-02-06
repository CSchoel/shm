within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
model ConstantPacemaker
  extends SHM.SchoelzelThesis.Components.Contraction.Unidirectional.Pacemaker;
  parameter Real T = 1;
equation
  der(phase) = 1/T;
end ConstantPacemaker;
