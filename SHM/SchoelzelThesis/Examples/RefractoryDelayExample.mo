within SHM.SchoelzelThesis.Examples;
model RefractoryDelayExample
  extends SHM.SchoelzelThesis.Examples.RefractoryExample;
  SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay.ConstantConductionDelay cd(duration_constant=0.2);
  Real test(start=0, fixed=true);
equation
  der(test) = 1;
  connect(cd.inp, gate.outp);
  when cd.outp then
    reinit(test, 0);
  end when;
  annotation(
    experiment(StartTime=0, StopTime=5, Tolerance=1e-6, Interval=0.1),
    __OpenModelica_simulationFlags(s = "dassl"),
    __MoST_experiment(variableFilter= "visible_output|test|gate.inp")
  );
end RefractoryDelayExample;
