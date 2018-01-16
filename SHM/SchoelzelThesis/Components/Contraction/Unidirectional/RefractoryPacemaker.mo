within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
model RefractoryPacemaker
  extends UnidirectionalContractionComponent;
  replaceable ConstantPacemaker pace;
  replaceable ConstantRefractoryGate gate;
equation
  connect(inp, pace.inp);
  connect(pace.outp, gate.inp);
  connect(pace.reset, gate.outp);
  connect(outp, gate.outp);
end RefractoryPacemaker;
