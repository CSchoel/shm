within SHM.Shared.Components.Contraction;
partial model RefractoryGateBD
  "lets signals pass only when a given"
  +"refractory time has passed since the last signal"
  extends SHM.Shared.Components.Contraction.BidirectionalContractionComponent;
  parameter Real t_first(start=0, fixed=true);
  Real T_refrac;
protected
  Real t_last(start=t_first);
  Boolean refractory = time - pre(t_last) <= T_refrac;
equation
  left.outgoing = right.incoming and not refractory;
  right.outgoing = left.incoming and not refractory;
  when left.incoming or right.incoming then
    t_last = time;
  end when;
end RefractoryGateBD;
