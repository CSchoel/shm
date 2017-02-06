within SHM.SchoelzelThesis.Examples;
model RefractoryExample
  SHM.SchoelzelThesis.Components.Contraction.ConstantRefractoryGate gate(duration=1);
  SHM.SchoelzelThesis.Components.Test.PeriodicTrigger trigger(T=0.8,start=0);
equation
  connect(gate.inp, trigger.outp);
end RefractoryExample;
