within SHM.SchoelzelThesis.Components.Contraction.Bidirectional;
model Pacemaker
  extends SHM.SchoelzelThesis.Components.Contraction.Bidirectional.
          BidirectionalContractionComponent;
  Real phase(start=0, fixed=true);
  SHM.Shared.Connectors.ExcitationInput refractory;
protected
  Boolean tick = phase >= 1;
equation
  up.upward = (down.upward or tick) and not refractory;
  down.downward = (up.downward or tick) and not refractory;
  when up.upward or down.downward then
    reinit(phase, 0);
  end when;
end Pacemaker;
