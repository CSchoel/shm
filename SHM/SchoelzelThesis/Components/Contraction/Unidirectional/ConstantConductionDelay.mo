within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
model ConstantConductionDelay
  extends SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ConductionDelay;
  parameter Real duration = 1;
equation
  continuous_outp = delay(continuous_inp, duration);
end ConstantConductionDelay;
