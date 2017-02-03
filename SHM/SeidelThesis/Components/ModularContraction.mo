within SHM.SeidelThesis.Components;
model ModularContraction
  import SHM.Shared.Components.Contraction.{
    ConstantRefractoryGate, ConstantPacemaker
  };
  import SHM.Shared.Connectors.{
    ExcitationInput, ExcitationOutput
  };
  import SHM.SeidelThesis.Components.{
    AVConductionDelay
  };
  ExcitationInput sinus;
  ExcitationOutput contraction;
  ConstantRefractoryGate sinus_refrac;
  AVConductionDelay av_delay;
  ConstantPacemaker av_node;
equation
  connect(sinus, sinus_refrac.inp);
  connect(sinus_refrac.outp, av_delay.inp);
  connect(av_delay.outp, av_node.external_stimulus);
  connect(av_node.signal, contraction);
end ModularContraction;
