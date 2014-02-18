within Kotani.Components;
model Heart
  Kotani.Components.Basic.BloodVessel artery annotation(Placement(transformation(origin = {-100,-1.14613}, extent = {{-10,-10},{10,10}}), iconTransformation(origin = {-100.573,0.573066}, extent = {{-10,-10},{10,10}})));
  Real S "contractility";
  Real tlast(start = 0) "timestamp of last heartbeat";
  Real plast(start = 0) "blood pressure at the end of the last diastole";
  Real test(start = 1);
  Kotani.Components.Basic.Saturation satS;
  parameter Real Tsys = 0.125 "duration of systole";
  parameter Real S0 = -13.8 "base Value for contractility";
  parameter Real facCcne = 10 "influence of cardiac concentration of Norepinephrine";
  parameter Real facCvne = 20 "influence of vascular concentration of Norepinephrine";
  parameter Real facT = 45 "influence of duration since last heartbeat";
  parameter Real maxS = 70 "saturation value for contractility";
  parameter Real satExpS = 2 "saturation exponent for contractility";
  parameter Real tauv0 = 2.8 "base value for time it takes until blood pressure (hypothetically) reaches zero";
  parameter Real facCvneWind = 1.2 "influence of vascular concentration of Norepinephrine on time it takes until blood pressure (hypothetically) reaches zero";
  Basic.NeurotransmitterConcentration ccne annotation(Placement(visible = true, transformation(origin = {104.89,99.6118}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {81.6,100}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Basic.HormoneConcentration cvne annotation(Placement(visible = true, transformation(origin = {-81.7087,98.4473}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-98.4,100}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Kotani.Components.Basic.DiscreteSignal sinusSignal annotation(Placement(visible = true, transformation(origin = {3.19725,98.9372}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-2.84732,96.756}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Kotani.Components.Basic.BloodVessel pdia;
  Kotani.Components.Basic.BloodVessel psys;
protected
  Real progress "progress of systole (rising from 0 to 1 linearly)";
  Real tauv "time until blood pressure (hypothetically) reaches zero";
  Boolean systole = time - tlast < Tsys;
equation
  psys.rate = der(psys.pressure);
  psys.pressure = 10;
  test = satS.satx;
  pdia.rate = der(pdia.pressure);
  pdia.rate = -pdia.pressure / tauv;
  satS.sat = maxS;
  satS.satexp = satExpS;
  satS.x = S;
  progress = (time - tlast) / Tsys;
  tauv = tauv0 - facCvneWind * cvne.concentration;
  artery.rate = 1;
  when sinusSignal.s >= 1 then
      S = S0 + facCcne * ccne.concentration + facT * (time - pre(tlast)) + facCvne * cvne.concentration;
    tlast = pre(time);
    plast = pre(artery.pressure);
  
  end when;
  annotation(Diagram(coordinateSystem(extent = {{-148.5,-105},{148.5,105}}, grid = {5,5})), experiment(StopTime = 1, StartTime = 0), Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Polygon(origin = {2.25166,-11.1836}, fillColor = {170,0,0}, fillPattern = FillPattern.Solid, points = {{-6.01366,52.0005},{10.6053,66.6137},{46.1353,77.2154},{73.356,63.7483},{79.3732,33.0893},{62.1812,0.424539},{-7.73286,-74.074},{-71.9162,7.0148},{-80.7988,39.1065},{-78.5065,62.6022},{-61.028,73.777},{-42.4033,72.0578},{-20.3403,66.9002},{-6.01366,52.0005}})}));
end Heart;

