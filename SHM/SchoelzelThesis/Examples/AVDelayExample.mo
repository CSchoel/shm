within SHM.SchoelzelThesis.Examples;
model AVDelayExample
  SHM.SchoelzelThesis.Components.Contraction.Unidirectional.AVConductionDelay del;
equation
  if time < 5 then
    del.inp = sample(0,1);
  elseif time < 15 then
    del.inp = sample(0,3);
  else
    del.inp = sample(0,0.05);
  end if;
end AVDelayExample;
