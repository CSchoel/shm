within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay;
model TimeDependentCD
  extends ConductionDelay;
  Real T(start=0, fixed=true);
  Real t_last(start=0, fixed=true);
equation
  when inp then
    T = time - pre(t_last);
    t_last = time;
  end when;
end TimeDependentCD;
