within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
partial model ConductionDelay
  extends UnidirectionalContractionComponent;
protected
  Real continuous_inp = if pre(inp) then 1.0 else 0.0 "auxiliary variable";
end ConductionDelay;
