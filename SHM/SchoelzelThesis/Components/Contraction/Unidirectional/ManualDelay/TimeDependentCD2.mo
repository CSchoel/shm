within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay;
model TimeDependentCD2
  extends ConductionDelay2(redeclare replaceable ConductionDelay strategy);
  Real T(start=0, fixed=true);
  Real t_last(start=0, fixed=true);
equation
  when inp then
    T = time - pre(t_last);
    t_last = time;
  end when;
end TimeDependentCD2;
