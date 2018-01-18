within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay;
model ConductionDelay2
  extends UnidirectionalContractionComponent;
  replaceable ConductionDelayStrategy strategy;
  Real duration = strategy.duration;
equation
  inp = strategy.inp;
  outp = strategy.outp;
end ConductionDelay2;
