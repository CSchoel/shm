within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.BuiltinDelay;
model SafeTimeDependentCD
  extends ConductionDelay;
  Real T(start=0, fixed=true);
  Real t_last(start=0, fixed=true);
  parameter Real delay_max = 1;
  Real duration(start=1);
protected
  Real silentUntil(start=-1, fixed=true);
  Real holdValue(start=0, fixed=true);
equation
  if time < silentUntil then
    continuous_outp = holdValue;
  else
    continuous_outp = delay(continuous_inp, duration, delay_max);
  end if;
  when inp then
    T = time - pre(t_last);
    t_last = time;
    silentUntil = max(pre(silentUntil), time + duration - pre(duration));
    holdValue = continuous_outp;
  end when;
end SafeTimeDependentCD;
