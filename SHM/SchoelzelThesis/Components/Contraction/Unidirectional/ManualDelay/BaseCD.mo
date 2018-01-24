within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay;
model BaseCD
  extends ConductionDelay;
  replaceable ConductionDelayStrategy strategy;
equation
  inp = strategy.inp;
  outp = strategy.outp;
end BaseCD;
