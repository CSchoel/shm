within SHM.SchoelzelThesis.Examples;
model ExtraSystoleExample
  SHM.SchoelzelThesis.Components.Contraction.Unidirectional.Simplified.ExtraSystole.ModularContractionX con;
  Real T(start=1, fixed=true);
  Real t_last_cont(start=0, fixed=true);
  Real t_last_sig(start=0, fixed=true);
  Integer count_sig(start=0, fixed=true);
  parameter Boolean with_sinus = true;
  parameter Real T_normal = if with_sinus then 0.8 else con.pace.T "75 bpm";
  Real t_since_sig = time - pre(t_last_sig) "time since last signal from AV/SA node";
  Real t_since_cont = time - pre(t_last_cont) "time since last contraction";
  Boolean pvc_a = pre(count_sig) == 5 and t_since_sig > con.cdelay.T_avc0 / 2
    "timer for PVC a): while 6th beat is delayed";
  Boolean pvc_b = pre(count_sig) == 12 and t_since_sig > con.refrac.T_refrac / 2
    "timer for PVC b): after 12th beat within refractory period";
  Boolean pvc_c = pre(count_sig) == 19 and t_since_sig > T_normal / 2
    "timer for PVC c): between 18th and 19th beat (after refractory period)";
  Boolean pvc_d = pre(count_sig) == 26 and
    t_since_sig > T_normal - con.cdelay.T_avc0 / 2
    "timer for PVC d): just before the 27th beat was signalled";
  Boolean trigger = pvc_a or pvc_b or pvc_c or pvc_d "pvc trigger signal";
equation
  con.pvc = edge(trigger);
  if with_sinus then
    con.inp = sample(0, T_normal) "undisturbed normal sinus rhythm";
  else
    con.inp = false "no sinus, only AVN";
  end if;
  when con.refrac.outp then
    count_sig = pre(count_sig) + 1;
    t_last_sig = time;
  end when;
  when con.outp then
    t_last_cont = time;
    T = t_since_cont;
  end when;
  annotation(
    experiment(StartTime = 0, StopTime = 55, Tolerance = 1e-6, Interval = 0.002),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl")
  );
end ExtraSystoleExample;
