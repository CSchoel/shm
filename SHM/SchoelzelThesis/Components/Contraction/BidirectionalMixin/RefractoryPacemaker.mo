within SHM.SchoelzelThesis.Components.Contraction.BidirectionalMixin;
model RefractoryPacemaker
  extends SHM.SchoelzelThesis.Components.Contraction.Bidirectional.BidirectionalContractionComponent;
  import SHM.SchoelzelThesis.Components.Contraction.{
    RefractoryMixinBD, PacemakerMixinBD
  };
  replaceable RefractoryMixinBD refrac;
  replaceable PacemakerMixinBD pace;
  inner Boolean refractory;
  inner Boolean pacemaker_reset;
protected
  inner Boolean refrac_signal;
equation
  refrac_signal = up_incoming or down_incoming or pace.tick;
  pacemaker_reset = refrac_signal and not refractory;
end RefractoryPacemaker;
