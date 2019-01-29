within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.Simplified;
model ModularContraction
  extends UnidirectionalContractionComponent;
  RefractoryGate refrac;
  ConstantPacemaker pace;
  AVConductionDelay cdelay;
equation
  connect(inp, pace.inp);
  connect(pace.outp, refrac.inp);
  connect(refrac.outp, pace.reset);
  connect(refrac.outp, cdelay.inp);
  connect(cdelay.outp, outp);
end ModularContraction;
