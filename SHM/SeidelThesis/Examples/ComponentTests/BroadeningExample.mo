within SHM.SeidelThesis.Examples.ComponentTests;
model BroadeningExample
  SHM.SeidelThesis.Components.Broaden broad(resolution=100);
  Real x(start = 10,fixed=true);
  Real xbroad;
equation
  der(x) = if time >= 1 and time <= 2 then 100 else 0;
  broad.x = x;
  broad.xbroad = xbroad;
end BroadeningExample;