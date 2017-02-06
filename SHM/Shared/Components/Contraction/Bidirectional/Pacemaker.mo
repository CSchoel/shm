within SHM.Shared.Components.Contraction.Bidirectional;
model Pacemaker
  extends SHM.Shared.Components.Contraction.BidirectionalContractionComponent;
  Real phase(start=0, fixed=true);
  SHM.Shared.Connectors.ExcitationInput refractory;
protected
  Boolean tick = phase >= 1;
equation
  up_outgoing = (down_incoming or tick) and not refractory;
  down_outgoing = (up_incoming or tick) and not refractory;
  when up_outgoing or down_outgoing then
    reinit(phase, 0);
  end when;
end Pacemaker;
