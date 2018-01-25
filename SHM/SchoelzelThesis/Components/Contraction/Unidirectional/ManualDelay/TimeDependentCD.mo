within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay;
partial model TimeDependentCD
  extends BaseCD;
  Real T(start=0, fixed=true);
  Real t_last(start=0, fixed=true);
equation
  when inp then
    T = time - pre(t_last);
    t_last = time;
  end when;
end TimeDependentCD;
