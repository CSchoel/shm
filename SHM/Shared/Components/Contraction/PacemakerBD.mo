within SHM.Shared.Components.Contraction;
model PacemakerBD
  extends SHM.Shared.Components.Contraction.BidirectionalContractionComponent;
  Real phase(start=0, fixed=true);
protected
  Boolean tick = phase >= 1;
equation
  up.outgoing = down.incoming or tick;
  down.outgoing = up.incoming or tick;
  when up.outgoing or down.outgoing then
    reinit(phase, 0);
  end when;
end PacemakerBD;
