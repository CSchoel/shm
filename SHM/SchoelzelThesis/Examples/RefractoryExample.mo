within SHM.SchoelzelThesis.Examples;
model RefractoryExample
  SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ConstantRefractoryGate gate(T_refrac=1);
  SHM.Shared.Components.Test.PeriodicExcitation trigger(T=0.8,start=0);
equation
  connect(gate.inp, trigger.outp);
  annotation(
    experiment(StartTime=0, StopTime=5, Tolerance=1e-6, Interval=0.1),
    __OpenModelica_simulationFlags(s = "dassl"),
    __MoST_experiment(variableFilter= "^gate.(inp|outp)$")
  );
end RefractoryExample;
