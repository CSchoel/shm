within SHM.SeidelThesis.Examples.ComponentTests;
model ContractionExample
  SHM.SeidelThesis.Components.Contraction cont;
equation
  if time < 5 then
    cont.signal = sample(0,1);
  elseif time < 15 then
    cont.signal = sample(0,3);
  else
    cont.signal = sample(0,0.2);
  end if;
end ContractionExample;