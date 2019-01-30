within SHM.SchoelzelThesis.Examples;
model ExtraSystoleExample
  SHM.SchoelzelThesis.Components.Contraction.Unidirectional.Simplified.ExtraSystole.ModularContractionX con;
  Real T(start=1, fixed=true);
  Real t_last(start=0, fixed=true);
  Integer count(start=0, fixed=true);
equation
  con.inp = sample(0, 0.8);
  con.extra = sample(0, 0.9);
  when con.outp then
    t_last = time;
    T = time - pre(t_last);
    count = pre(count) + 1;
  end when;
end ExtraSystoleExample;
