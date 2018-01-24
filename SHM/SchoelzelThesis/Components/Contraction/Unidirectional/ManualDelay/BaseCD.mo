within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay;
model BaseCD
  extends UnidirectionalContractionComponent;
  replaceable ConductionDelayStrategy strategy;
  Real duration = strategy.duration;
equation
  inp = strategy.inp;
  outp = strategy.outp;
end BaseCD;
