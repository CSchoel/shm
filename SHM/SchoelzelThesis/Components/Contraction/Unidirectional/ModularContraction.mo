within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
model ModularContraction
  extends SHM.SchoelzelThesis.Components.Contraction.Unidirectional.UnidirectionalContractionComponent;
  import SHM.SchoelzelThesis.Components.Contraction.Unidirectional.{
    ConstantPacemaker, ConstantRefractoryGate
  };
  import SHM.SchoelzelThesis.Components.Contraction.Unidirectional.InternalDelay.AVConductionDelay;
  AVConductionDelay av_delay(delay_max=3);
  RefractoryPacemaker av(gate.duration=0.9, pace.T=1.7);
equation
  connect(inp, av_delay.inp);
  connect(av_delay.outp, av.inp);
  connect(av.outp, outp);
end ModularContraction;
