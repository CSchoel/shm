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
  refrac_signal = up_incoming or down_incoming or pace.tick;
  pacemaker_reset = refrac_signal and not refractory;
  up_outgoing = (pace.tick or down_incoming) and not refractory;
  down_outgoing = (pace.tick or up_incoming) and not refractory;
end RefractoryPacemaker;
