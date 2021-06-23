within SHM.SchoelzelThesis.Examples;
model AVDelayExample
  SHM.SchoelzelThesis.Components.Contraction.Unidirectional.BuiltinDelay.AVConductionDelay del;
  SHMConduction.Components.AVConductionDelay del2;
  SHM.SchoelzelThesis.Components.Contraction.Unidirectional.BuiltinDelay.SafeAVConductionDelay dels;
  discrete Real countIn(start=0, fixed=true);
  discrete Real countOut(start=0, fixed=true);
  discrete Real countOuts(start=0, fixed=true);
equation
  del2.inp = del.inp;
  dels.inp = del.inp;
  if time < 5 then
    del.inp = sample(0,1);
  elseif time < 15 then
    del.inp = sample(0,3);
  elseif time < 22 then
    del.inp = sample(0,0.05);
  else
    del.inp = false;
  end if;
  when del.inp then
    countIn = pre(countIn) + 1;
  end when;
  when del.outp then
    countOut = pre(countOut) + 1;
  end when;
  when dels.outp then
    countOuts = pre(countOuts) + 1;
  end when;
annotation(
  experiment(StartTime=0, StopTime=30, Tolerance=1e-6, Interval=0.01),
  __OpenModelica_simulationFlags(s = "dassl"),
  __MoST_experiment(variableFilter= "count.*")
);
end AVDelayExample;
