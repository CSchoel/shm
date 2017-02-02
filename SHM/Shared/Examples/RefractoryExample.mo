within SHM.Shared.Examples;
model RefractoryExample
  SHM.Shared.Components.Contraction.ConstantRefractoryGate gate(duration=1);
  SHM.Shared.Components.Test.PeriodicTrigger trigger(T=0.8,start=0);
equation
  connect(gate.inp, trigger.outp);
end RefractoryExample;
