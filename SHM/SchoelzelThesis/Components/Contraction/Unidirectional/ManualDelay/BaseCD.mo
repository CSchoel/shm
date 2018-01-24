within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay;
model BaseCD
  extends ConductionDelay;
  replaceable model Strategy = SingleCD constrainedby ConductionDelay;
  Strategy internalCD(inp=inp, outp=outp, duration=duration);
end BaseCD;
