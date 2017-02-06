within SHM.Shared.Components.Contraction;
model RefractoryMixinBD
  parameter Real t_first(start=0, fixed=true);
  outer Boolean refractory = time - pre(t_last) <= T_refrac;
protected
  Real t_last(start=t_first);
  Real T_refrac;
  outer Boolean refrac_signal(start=false, fixed=true);
equation
  when refrac_signal then
    t_last = time;
  end when;
end RefractoryMixinBD;
