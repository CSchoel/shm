within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
model ModularContraction
  extends SHM.SchoelzelThesis.Components.Contraction.Unidirectional.UnidirectionalContractionComponent;
  import SHM.SchoelzelThesis.Components.Contraction.Unidirectional.{
    AVConductionDelay, ConstantPacemaker, ConstantRefractoryGate
  };
  AVConductionDelay av_delay;
  ConstantPacemaker av;
  ConstantRefractoryGate san_refrac;
equation
  connect(inp, san_refrac.inp);
  connect(san_refrac.outp, av.inp);
  connect(av.outp, av_delay.inp);
  connect(av_delay.outp, outp);
end ModularContraction;
