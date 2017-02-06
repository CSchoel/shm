within SHM.SchoelzelThesis.Examples;
model PacemakerExample
  SHM.SchoelzelThesis.Components.Contraction.ConstantPacemaker pm(T=0.9);
  Real x(start=0, fixed=true);
equation
  pm.external_stimulus.s = if time < 5 then sample(0,0.5) else sample(0,1);
  der(x) = 1;
  when pm.signal.s then
    reinit(x, 0);
  end when;
end PacemakerExample;
