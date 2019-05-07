within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.Simplified.ExtraSystole;
model ModularContractionX
  extends UnidirectionalContractionComponent;
  RefractoryGateX refrac(T_refrac=0.364);
  ConstantPacemaker pace;
  AVConductionDelayX cdelay;
  RefractoryGate vref(T_refrac=0.2);
  input Boolean pvc;
equation
  connect(inp, pace.inp);
  connect(pace.outp, refrac.inp);
  connect(refrac.outp, cdelay.inp);
  vref.inp = pvc or cdelay.outp;
  connect(vref.outp, outp);
  pace.reset = pvc or refrac.outp;
  connect(pvc, refrac.reset);
  connect(pvc, cdelay.reset);
end ModularContractionX;
