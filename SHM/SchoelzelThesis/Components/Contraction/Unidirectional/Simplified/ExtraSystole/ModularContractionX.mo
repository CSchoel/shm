within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.Simplified.ExtraSystole;
model ModularContractionX
  extends UnidirectionalContractionComponent;
  RefractoryGateX refrac(T_refrac=0.364);
  ConstantPacemaker pace(T=1.7);
  AVConductionDelayX cdelay;
  RefractoryGate vref(T_refrac=0.2);
  input Boolean pvc;
  Boolean pvc_upward = pre(pvc) and pre(outp) "true if we have PVC that travels upward";
equation
  connect(inp, pace.inp);
  connect(pace.outp, refrac.inp);
  connect(refrac.outp, cdelay.inp);
  vref.inp = pvc or cdelay.outp;
  connect(vref.outp, outp);
  pace.reset = pvc_upward or refrac.outp;
  connect(pvc_upward, refrac.reset);
  connect(pvc_upward, cdelay.reset);
end ModularContractionX;
