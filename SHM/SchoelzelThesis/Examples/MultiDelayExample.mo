within SHM.SchoelzelThesis.Examples;
model MultiDelayExample
  import SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay.{
    ConstantMultiCD, ConstantConductionDelay
  };
  parameter Real d = 1;
  parameter Real sample_freq = 1.2;
  parameter Boolean use_single = true;
  ConstantMultiCD mcd(duration_constant=d);
  ConstantConductionDelay ccd(duration_constant=d) if use_single;
  Integer count_multi(start=0, fixed=true);
  Integer count_single(start=0, fixed=true) if use_single;
equation
  if use_single then
    mcd.inp = ccd.inp;
    when ccd.outp then
      count_single = pre(count_single) + 1;
    end when;
  end if;
  mcd.inp = sample(sample_freq, sample_freq);
  when mcd.outp then
    count_multi = pre(count_multi) + 1;
  end when;
end MultiDelayExample;
