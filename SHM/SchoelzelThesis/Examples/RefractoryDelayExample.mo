within SHM.SchoelzelThesis.Examples;
model RefractoryDelayExample
  extends SHM.SchoelzelThesis.Examples.RefractoryExample;
  SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ConstantConductionDelay cd(delay_constant=0.2);
  Real test(start=0, fixed=true);
equation
  der(test) = 1;
  connect(cd.inp, gate.outp);
  when cd.outp then
    reinit(test, 0);
  end when;
end RefractoryDelayExample;
