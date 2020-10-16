within SHM.SchoelzelThesis.Components.Contraction.Bidirectional;
partial model RefractoryGate
  "lets signals pass only when a given"
  +"refractory time has passed since the last signal"
  extends SHM.SchoelzelThesis.Components.Contraction.Bidirectional.
          BidirectionalContractionComponent;
  parameter Real t_first = 0;
  Real T_refrac;
  SHM.Shared.Connectors.ExcitationOutput refractory;
protected
  Real t_last(start=t_first);
equation
  refractory = time - pre(t_last) <= T_refrac;
  up.upward = down.upward and not refractory;
  down.downward = up.downward and not refractory;
  when up.downward or down.upward then
    t_last = time;
  end when;
end RefractoryGate;
