within SHM.SchoelzelThesis.Examples;
model MultiDelayExample
  import SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay.{
    ConstantMultiCD, ConstantConductionDelay
  };
  parameter Real d = 1;
  ConstantMultiCD mcd(duration_constant=d);
  ConstantConductionDelay ccd(duration_constant=d);
equation
  mcd.inp = ccd.inp;
  mcd.inp = sample(1.2,1.2);
end MultiDelayExample;
