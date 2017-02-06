within SHM.SchoelzelThesis.Components.Contraction.BidirectionalMixin;
model RefractoryPacemaker
  extends SHM.SchoelzelThesis.Components.Contraction.Bidirectional.BidirectionalContractionComponent;
  import SHM.SchoelzelThesis.Components.Contraction.BidirectionalMixin.{
    RefractoryMixin, PacemakerMixin
  };
  replaceable RefractoryMixin refrac;
  replaceable PacemakerMixin pace;
  inner Boolean refractory;
  inner Boolean pacemaker_reset;
protected
  inner Boolean refrac_signal;
equation
  refrac_signal = up.upward or down.downward;
  pacemaker_reset = refrac_signal and not refractory;
  up.upward = (pace.tick or down.upward) and not refractory;
  down.downward = (pace.tick or up.downward) and not refractory;
end RefractoryPacemaker;
