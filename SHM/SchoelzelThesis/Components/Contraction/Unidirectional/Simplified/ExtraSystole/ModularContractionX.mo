within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.Simplified.ExtraSystole;
model ModularContractionX
  extends UnidirectionalContractionComponent;
  RefractoryGateX refrac(T_refrac=0.364);
  ConstantPacemaker pace(T=1.7);
  AVConductionDelayX cdelay;
  input Boolean extra;
equation
  connect(inp, pace.inp);
  connect(pace.outp, refrac.inp);
  //connect(refrac.outp, pace.reset);
  connect(refrac.outp, cdelay.inp);
  outp = extra or cdelay.outp;
  // TODO we need an additional refractory component for the ventricles here
  pace.reset = extra or refrac.outp;
  connect(extra, refrac.reset);
  connect(extra, cdelay.clear);
end ModularContractionX;
