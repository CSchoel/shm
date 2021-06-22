within SHM.SchoelzelThesis.Examples;
model MultiDelayExample
  import SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay.{
    ConstantConductionDelay, MultiCD
  };
  parameter Real d = 1;
  parameter Real sample_freq = 1.2;
  ConstantConductionDelay mcd(duration_constant=d, redeclare model Strategy = MultiCD);
  ConstantConductionDelay ccd(duration_constant=d);
  Integer count_multi(start=0, fixed=true);
  Integer count_single(start=0, fixed=true);
equation
  mcd.inp = ccd.inp;
  when ccd.outp then
    count_single = pre(count_single) + 1;
  end when;
  mcd.inp = sample(sample_freq, sample_freq);
  when mcd.outp then
    count_multi = pre(count_multi) + 1;
  end when;
end MultiDelayExample;
