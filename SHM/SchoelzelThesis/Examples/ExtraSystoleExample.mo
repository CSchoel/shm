within SHM.SchoelzelThesis.Examples;
model ExtraSystoleExample
  SHM.SchoelzelThesis.Components.Contraction.Unidirectional.Simplified.ExtraSystole.ModularContractionX con;
  Real T(start=1, fixed=true);
  Real t_last(start=0, fixed=true);
  Integer count(start=0, fixed=true);
  Boolean trigger;
  parameter Boolean with_sinus = true;
  parameter Real T_normal = if with_sinus then 0.8 else con.pace.T;
  Real t_passed = time - pre(t_last);
equation
  // TODO: is it better to use magic numbers than strange formulas?
  trigger =
    // while 6th beat is delayed
    (pre(count) == 5 and t_passed > T_normal - con.cdelay.T_avc0/2)
    // after 12th beat within refractory period
    or (pre(count) == 12 and t_passed > con.refrac.T_refrac/2)
    // between 18th and 19th beat (after refractory period)
    or (pre(count) == 18 and t_passed > T_normal/2 - con.cdelay.T_avc0)
    // just before the 24th beat was signalled
    or (pre(count) == 23 and t_passed > T_normal - con.cdelay.T_avc0 * 1.5);
  con.pvc = edge(trigger);
  if with_sinus then
    con.inp = sample(0, T_normal) "75 bpm";
  else
    con.inp = false "no sinus, only AVN";
  end if;
  when con.outp then
    t_last = time;
    T = t_passed;
    count = pre(count) + 1;
  end when;
  annotation(
    experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-6, Interval = 0.002),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl")
  );
end ExtraSystoleExample;
