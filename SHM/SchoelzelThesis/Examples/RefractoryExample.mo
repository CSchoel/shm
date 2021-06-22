within SHM.SchoelzelThesis.Examples;
model RefractoryExample
  SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ConstantRefractoryGate gate(duration=1);
  SHM.Shared.Components.Test.PeriodicExcitation trigger(T=0.8,start=0);
  Real visible_output(start=0, fixed=true);
equation
  der(visible_output) = 1;
  when gate.outp then
    reinit(visible_output, 0);
  end when;
  connect(gate.inp, trigger.outp);
  annotation(
    experiment(StartTime=0, StopTime=5, Tolerance=1e-6, Interval=0.1),
    __OpenModelica_simulationFlags(s = "dassl"),
    __MoST_experiment(variableFilter= "gate.inp|visible_output")
  );
end RefractoryExample;
