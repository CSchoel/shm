within SHM.SchoelzelThesis.Examples;
model AVDelayExample
  SHM.SchoelzelThesis.Components.Contraction.Unidirectional.InternalDelay.AVConductionDelay del;
  SHM.SchoelzelThesis.Components.Contraction.Unidirectional.InternalDelay.SafeAVConductionDelay dels;
  discrete Real countIn(start=0, fixed=true);
  discrete Real countOut(start=0, fixed=true);
  discrete Real countOuts(start=0, fixed=true);
equation
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
end AVDelayExample;
