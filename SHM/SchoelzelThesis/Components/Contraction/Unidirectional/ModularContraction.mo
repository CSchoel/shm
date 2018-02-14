within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
model ModularContraction
  extends SHM.SchoelzelThesis.Components.Contraction.Unidirectional.UnidirectionalContractionComponent;
  import SHM.SchoelzelThesis.Components.Contraction.Unidirectional.{
    ConstantPacemaker, ConstantRefractoryGate
  };
  import SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay.{
    AVConductionDelay, MultiCD
  };
  // TODO find good value for pacemaker delay (should be 0.22 + average conduction delay)
  parameter Real T_refrac = 0.33;
  AVConductionDelay av_delay(redeclare model Strategy = MultiCD(min_dist=T_refrac));
  RefractoryPacemaker av(gate.T_refrac=T_refrac, pace.T=1.7);
equation
  connect(inp, av.inp);
  connect(av.outp, av_delay.inp);
  connect(av_delay.outp, outp);
end ModularContraction;
