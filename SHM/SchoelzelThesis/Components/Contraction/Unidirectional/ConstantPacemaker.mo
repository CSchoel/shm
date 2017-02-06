within SHM.SchoelzelThesis.Components.Contraction;
model ConstantPacemaker
  extends SHM.SchoelzelThesis.Components.Contraction.Pacemaker;
  parameter Real T = 1;
equation
  der(phase) = 1/T;
end ConstantPacemaker;
