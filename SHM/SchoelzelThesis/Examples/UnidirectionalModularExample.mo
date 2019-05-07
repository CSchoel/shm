within SHM.SchoelzelThesis.Examples;
model UnidirectionalModularExample
  SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ModularContraction mc(T_refrac=0.364);
  SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ModularContractionSHM mco;
  SHM.SeidelThesis.Components.Contraction2 c2;
  Real count_mc(start=0, fixed=true);
  Real count_c2(start=0, fixed=true);
  Real count_mco(start=0, fixed=true);
equation
  mc.inp = c2.signal;
  mco.inp = c2.signal;
  if time < 5 then
    c2.signal = sample(0,1);
  elseif time < 15 then
    c2.signal = sample(0,3);
  elseif time < 20 then
    // during Afib, atrial impulses occur at up to 600/min => with distance 0.1s
    // source: https://my.clevelandclinic.org/health/diseases/16765-atrial-fibrillation-afib
    c2.signal = sample(0,0.05);
  elseif time < 30 then
    c2.signal = sample(0,0.8);
  elseif time < 40 then
    c2.signal = sample(0,0.2);
  else
    c2.signal = sample(0,1.8);
  end if;
  when c2.contraction then
    count_c2 = pre(count_c2) + 1;
  end when;
  when mc.outp then
    count_mc = pre(count_mc) + 1;
  end when;
  when mco.outp then
    count_mco = pre(count_mco) + 1;
  end when;
  annotation(
    experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-6, Interval = 0.002),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl")
  );
end UnidirectionalModularExample;
