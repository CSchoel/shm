within Kotani.Components;
model Heart
  Kotani.Components.Basic.BloodVessel artery annotation(Placement(transformation(origin = {-100,-1.14613}, extent = {{-10,-10},{10,10}}), iconTransformation(origin = {-100.573,0.573066}, extent = {{-10,-10},{10,10}})));
  discrete Real S(start = 0) "contractility";
  discrete Real tlast(start = 0) "timestamp of last heartbeat";
  discrete Real plast(start = 0) "blood pressure at the end of the last diastole";
  //discrete Real Tlast(start = 0) "duration of last cycle";
  Kotani.Components.Basic.Saturation satS;
  Kotani.Components.Basic.Saturation satCvne;
  parameter Real Tsys = 0.125 "duration of systole";
  parameter Real S0 = -13.8 "base Value for contractility";
  parameter Real facCcne = 10 "influence of cardiac concentration of Norepinephrine";
  parameter Real facCvne = 20 "influence of vascular concentration of Norepinephrine";
  parameter Real facT = 45 "influence of duration since last heartbeat";
  parameter Real maxS = 70 "saturation value for contractility";
  parameter Real satExpS = 2 "saturation exponent for contractility";
  parameter Real tauv0 = 2.8 "base value for time it takes until blood pressure (hypothetically) reaches zero";
  parameter Real facCvneWind = 1.2 "influence of vascular concentration of Norepinephrine on time it takes until blood pressure (hypothetically) reaches zero";
  parameter Real satExpCvne = 1.5 "saturation exponent (speed) for vascular concentration of Norepinephrine";
  parameter Real maxCvne = 1 "saturation value for vascular concentration of Norepinephrine";
  Basic.NeurotransmitterConcentration ccne annotation(Placement(visible = true, transformation(origin = {104.89,99.6118}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {81.6,100}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Basic.HormoneConcentration cvne annotation(Placement(visible = true, transformation(origin = {-81.7087,98.4473}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-98.4,100}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Kotani.Components.Basic.DiscreteSignal sinusSignal annotation(Placement(visible = true, transformation(origin = {3.19725,98.9372}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-2.84732,96.756}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Real pdia(start = 0);
  Real rdia(start = 0);
  Real psys(start = 0);
  Real rsys(start = 0);
protected
  Real progress "progress of systole (rising from 0 to 1 linearly)";
  Real tauv "time until blood pressure (hypothetically) reaches zero";
  Boolean systole = time - tlast < Tsys;
equation
  satCvne.satexp = satExpCvne;
  satCvne.sat = maxCvne;
  satCvne.x = cvne.concentration;
  rsys = der(psys);
  rsys = 1 / Tsys * satS.satx * (1 - progress) * exp(1 - progress);
  //rsys is a manual differentiation of the following equation from the kotani model
  //psys = plast + satS.satx * progress * exp(1 - progress);
  rdia = der(pdia);
  rdia = -pdia / tauv;
  satS.sat = maxS;
  satS.satexp = satExpS;
  satS.x = S;
  progress = (time - tlast) / Tsys;
  tauv = tauv0 - facCvneWind * satCvne.satx;
  artery.rate = if systole then -rsys else -rdia;
  when sinusSignal.s >= 1 then
    S = S0 + facCcne * ccne.concentration + facT * (time - pre(tlast)) + facCvne * cvne.concentration;
    tlast = time;
    plast = pre(artery.pressure);
    reinit(psys, plast);
  end when;
  when not systole then
    reinit(pdia, artery.pressure);
  end when;
  //we do not change inputs
  ccne.rate = 0;
  cvne.rate = 0;
  annotation(Diagram(coordinateSystem(extent = {{-148.5,-105},{148.5,105}}, grid = {5,5})), experiment(StopTime = 1, StartTime = 0), Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Polygon(origin = {2.25166,-11.1836}, fillColor = {170,0,0}, fillPattern = FillPattern.Solid, points = {{-6.01366,52.0005},{10.6053,66.6137},{46.1353,77.2154},{73.356,63.7483},{79.3732,33.0893},{62.1812,0.424539},{-7.73286,-74.074},{-71.9162,7.0148},{-80.7988,39.1065},{-78.5065,62.6022},{-61.028,73.777},{-42.4033,72.0578},{-20.3403,66.9002},{-6.01366,52.0005}})}));
end Heart;