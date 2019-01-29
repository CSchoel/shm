within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.Simplified.ExtraSystole;
model ModularContractionX
  extends UnidirectionalContractionComponent;
  RefractoryGateX refrac;
  ConstantPacemaker pace;
  AVConductionDelayX cdelay;
  input Boolean extra;
equation
  connect(inp, pace.inp);
  connect(pace.outp, refrac.inp);
  //connect(refrac.outp, pace.reset);
  connect(refrac.outp, cdelay.inp);
  connect(cdelay.outp, outp);
  pace.reset = extra or refrac.outp;
  connect(extra, refrac.reset);
  connect(extra, cdelay.clear);
end ModularContractionX;
