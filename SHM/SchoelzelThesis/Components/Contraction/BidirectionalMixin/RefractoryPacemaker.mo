within SHM.SchoelzelThesis.Components.Contraction.BidirectionalMixin;
model RefractoryPacemaker
  extends SHM.SchoelzelThesis.Components.Contraction.Bidirectional.BidirectionalContractionComponent;
  import SHM.SchoelzelThesis.Components.Contraction.BidirectionalMixin.{
    RefractoryMixin, PacemakerMixin
  };
  // NOTE: this component would be more reusable if refrac and pace
  // were replaceable. However, OpenModelica 1.17 currently does not support
  // this.
  ConstantRefractoryMixin refrac;
  ConstantPacemakerMixin pace;
  inner Boolean refractory;
  inner Boolean pacemaker_reset;
  inner Boolean refrac_signal;
equation
  refrac_signal = up.upward or down.downward;
  pacemaker_reset = refrac_signal and not refractory;
  up.upward = (pace.tick or down.upward) and not refractory;
  down.downward = (pace.tick or up.downward) and not refractory;
end RefractoryPacemaker;
