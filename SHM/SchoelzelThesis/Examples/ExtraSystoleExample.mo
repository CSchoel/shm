within SHM.SchoelzelThesis.Examples;
model ExtraSystoleExample
  SHM.SchoelzelThesis.Components.Contraction.Unidirectional.Simplified.ExtraSystole.ModularContractionX con;
  Real T(start=1, fixed=true);
  Real t_last(start=0, fixed=true);
  Integer count(start=0, fixed=true);
  parameter Boolean with_sinus = true;
equation
  if with_sinus then
    con.inp = sample(0, 0.8) "75 bpm";
    con.extra = sample(0.8 * 6 + 0.01, 100)   // while 6th beat is delayed
             or sample(0.8 * 12 + 0.15, 100)  // after 12th beat within refractory period
             or sample(0.8 * 18 + 0.4, 100)   // after 18th beat after refractory period
             or sample(0.8 * 24 - 0.01, 100); // just before the 24th beat
  else
    con.inp = false "no sinus, only AVN";
    con.extra = sample(1.7 * 6 + 0.01, 100)   // while 6th AV beat is delayed
             or sample(1.7 * 12 + 0.15, 100)  // after 12th AV beat within refractory period
             or sample(1.7 * 18 + 0.8, 100)   // after 18th AV beat after refractory period
             or sample(1.7 * 24 - 0.01, 100); // just before the 24th AV beat
  end if;
  when con.outp then
    t_last = time;
    T = time - pre(t_last);
    count = pre(count) + 1;
  end when;
  annotation(
    experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-6, Interval = 0.002),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl")
  );
end ExtraSystoleExample;
