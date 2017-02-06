within SHM.SchoelzelThesis.Examples;
model RefractoryDelayExample
  extends SHM.SchoelzelThesis.Examples.RefractoryExample;
  SHM.SchoelzelThesis.Components.Contraction.ConstantConductionDelay cd(delayConstant=0.2);
  Real test(start=0, fixed=true);
equation
  der(test) = 1;
  connect(cd.inp, gate.outp);
  when cd.outp.s then
    reinit(test, 0);
  end when;
end RefractoryDelayExample;
