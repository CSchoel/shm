within SHM.SchoelzelThesis.Components.Contraction.BidirectionalMixin;
model RefractoryMixin
  parameter Real t_first = 0;
  outer Boolean refractory;
protected
  Real t_last(start=t_first);
  Real T_refrac;
  outer Boolean refrac_signal;
equation
  refractory = time - pre(t_last) <= T_refrac;
  when refrac_signal then
    t_last = time;
  end when;
end RefractoryMixin;
