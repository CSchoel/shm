within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.InternalDelay;
model ConstantConductionDelay
  extends ConductionDelay;
  parameter Real duration = 1;
equation
  continuous_outp = delay(continuous_inp, duration);
end ConstantConductionDelay;
