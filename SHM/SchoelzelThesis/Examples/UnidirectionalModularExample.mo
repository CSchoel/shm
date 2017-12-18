within SHM.SchoelzelThesis.Examples;
model UnidirectionalModularExample
  SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ModularContraction mc;
  SHM.SeidelThesis.Components.Contraction2 c2;
equation
  mc.inp = c2.signal;
  if time < 5 then
    c2.signal = sample(0,1);
  elseif time < 15 then
    c2.signal = sample(0,3);
  else
    c2.signal = sample(0,0.05);
  end if;
end UnidirectionalModularExample;
