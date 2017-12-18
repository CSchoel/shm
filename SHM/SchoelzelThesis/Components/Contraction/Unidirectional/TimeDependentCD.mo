within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
model TimeDependentCD
  extends SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ConductionDelay;
  Real T(start=0, fixed=true);
  Real t_last(start=0, fixed=true);
  parameter Real delay_max(start=1);
  Real duration(start=1);
equation
  outp = delay(continuous_inp, duration, delay_max) > 0.5;
  when inp then
    T = time - pre(t_last);
    t_last = time;
  end when;
end TimeDependentCD;
