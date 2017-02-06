within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
model TimeDependentCD
  extends SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ConductionDelay;
  Real T(start=0, fixed=true);
  Real t_last(start=0, fixed=true);
equation
  when inp.s then
    T = time - pre(t_last);
    t_last = time;
  end when;
end TimeDependentCD;
