within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.Simplified;
model ConstantPacemaker
  extends Pacemaker;
  parameter Real T = 1 "pacemaker period";
equation
  der(phase) = 1/T;
end ConstantPacemaker;
