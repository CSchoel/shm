within Kotani.Components;
model Heart
  Kotani.Components.Basic.BloodVessel artery annotation(Placement(visible = true, transformation(origin = {-100,-1.14613}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100.573,0.573066}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Kotani.Components.Basic.Nerve sinusNerve annotation(Placement(visible = true, transformation(origin = {-5.73066,99.7135}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-8.02292,99.7135}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Real S "contractility";
  Real tlast(start = 0) "timestamp of last heartbeat";
  Real plast(start = 0) "blood pressure at the end of the last diastole";
  Kotani.Basic.Saturation satS;
  parameter Real Tsys = 0 "duration of systole";
  parameter Real S0 = 0 "base Value for contractility";
  parameter Real facCcne = 0 "influence of cardiac concentration of Norepinephrine";
  parameter Real facCvne = 0 "influence of venous concentration of Norepinephrine";
  parameter Real facT = 0 "influence of duration since last heartbeat";
  parameter Real maxS = 0 "saturation value for contractility";
  parameter Real satExpS = 0 "saturation exponent for contractility";
protected
  Real progress "progress of systole (rising from 0 to 1 linearly)";
equation
  satS.sat = maxS;
  satS.satexp = satExpS;
  t = (time - tlast) / Tsys;
  p = plast + S * progress * exp(1 - progress);
  when sinusNerve.activation > 1 then
      satS.x = S0 + facCcne * ccne + facT * (time - pre(tlast)) + facCvne * cvne;
    tlast = time;
    plast = pre(artery.pressure);
  
  end when;
  annotation(Diagram(coordinateSystem(extent = {{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5,5})), Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Polygon(origin = {1.1426,-13.032}, fillColor = {170,0,0}, fillPattern = FillPattern.Solid, points = {{-6.01366,52.0005},{10.6053,66.6137},{46.1353,77.2154},{73.356,63.7483},{79.3732,33.0893},{62.1812,0.424539},{-7.73286,-74.074},{-71.9162,7.0148},{-80.7988,39.1065},{-78.5065,62.6022},{-61.028,73.777},{-42.4033,72.0578},{-20.3403,66.9002},{-6.01366,52.0005}})}));
end Heart;

