within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.BuiltinDelay;
model TimeDependentCD
  extends ConductionDelay;
  Real T(start=0, fixed=true);
  Real t_last(start=0, fixed=true);
  parameter Real delay_max = 1;
  Real duration(start=1);
equation
  continuous_outp = delay(continuous_inp, duration, delay_max);
  when inp then
    T = time - pre(t_last);
    t_last = time;
  end when;
end TimeDependentCD;
