within SHM.SchoelzelThesis.Examples;
model RefractoryExample
  SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ConstantRefractoryGate gate(duration=1);
  SHM.Shared.Components.Test.PeriodicExcitation trigger(T=0.8,start=0);
equation
  connect(gate.inp, trigger.outp);
end RefractoryExample;
