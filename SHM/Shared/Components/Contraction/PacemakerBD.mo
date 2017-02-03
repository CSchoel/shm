within SHM.Shared.Components.Contraction;
model PacemakerBD
  extends SHM.Shared.Components.Contraction.BidirectionalContractionComponent;
  Real phase(start=0, fixed=true);
protected
  Boolean tick = phase >= 1;
equation
  up_outgoing = down_incoming or tick;
  down_outgoing = up_incoming or tick;
  when up_outgoing or down_outgoing then
    reinit(phase, 0);
  end when;
end PacemakerBD;
