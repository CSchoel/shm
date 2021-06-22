within SHM.SchoelzelThesis.Examples;
model PacemakerExample
  SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ConstantPacemaker pm(T=0.9);
  Real x(start=0, fixed=true);
equation
  pm.inp = if time < 5 then sample(0,0.5) else sample(0,1);
  pm.reset = pm.outp;
  der(x) = 1;
  when pm.outp then
    reinit(x, 0);
  end when;
  annotation(
    experiment(StartTime=0, StopTime=10, Tolerance=1e-6, Interval=0.1),
    __OpenModelica_simulationFlags(s = "dassl"),
    __MoST_experiment(variableFilter= "^x$")
  );
end PacemakerExample;
