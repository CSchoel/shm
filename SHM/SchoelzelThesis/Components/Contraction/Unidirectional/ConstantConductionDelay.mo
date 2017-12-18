within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
model ConstantConductionDelay
  extends SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ConductionDelay;
  parameter Real duration = 1;
equation
  outp = delay(continuous_inp, duration) > 0.5;
end ConstantConductionDelay;
