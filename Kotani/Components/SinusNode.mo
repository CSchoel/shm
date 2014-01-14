within Kotani.Components;
model SinusNode
  parameter Real T0 = 0.6 "base rate at which sinus node fires without input from central nervous system";
  parameter Real sfsym = 1.6 "scaling factor for sympathetic influence on sinus node";
  parameter Real ccneMax = 2.0 "saturation value of cardiac concentration of Norepinephrine";
  parameter Real ccneSatexp = 2.0 "saturation exponent of cardiac concentration of Norepinephrine";
  parameter Real ccneUptake = 2.0 "time for total uptake of cardiac Norepinephrine";
  parameter Real ccneFac = 0.7 "factor how much cardiac Norepinephrine is released depending on sympathetic activity";
  parameter Real symDelay = 1.65 "time taken for sympathetic neural activity to trigger release of cardiac Norepinephrine";
  parameter Real paraDelay = 0.5 "time taken for a neural signal from the parasympathetic system to reach the sinus node";
  parameter Real paraMax = 2.5 "saturation value for the parasympathetic neural activity at the sinus node";
  parameter Real paraSatexp = 2 "saturation speed (exponent) of parasympathetic neural activity at the sinus node";
  parameter Real sfpara = 5.8 "sensitivity of the sinus node to parasympathetic activity";
  Kotani.Components.Basic.Nerve sympathicus annotation(Placement(visible = true, transformation(origin = {-100.0,100.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {-55.0297,57.0048}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
  Kotani.Components.Basic.Nerve parasympathicus annotation(Placement(visible = true, transformation(origin = {100.0,100.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {57.0507,56.5455}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
  Kotani.Components.Basic.Saturation satCcne;
  Kotani.Components.Basic.Saturation satPara;
  Kotani.Components.Basic.Nerve phase annotation(Placement(visible = true, transformation(origin = {-52.9167,-73.1738}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {0.0,-80.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
  Real fs "sympathetic influence on sinus node";
  Real ps "parasympathetic influence on sinus node";
  Real ccne "Cardiac Concentration of Norepinephrine";
equation
  satCcne.satexp = ccneSatexp;
  satCcne.sat = ccneMax;
  satCcne.x = ccne;
  satPara.satexp = paraSatexp;
  satPara.sat = paraMax;
  satPara.x = delay(parasympathicus.activation, paraDelay, paraDelay);
  der(ccne) = -ccne / ccneUptake + ccneFac * delay(sympathicus.activation, symDelay, symDelay);
  fs = 1 + sfsym * satCcne.satx;
  ps = 1 - sfpara * satPara.satx;
  phase.rate = 1 / T0 * fs * ps;
  when phase.activation > 1 then
      reinit(phase.activation, 0);
  
  end when;
  annotation(Icon(coordinateSystem(extent = {{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10,10}), graphics = {Text(visible = true, origin = {-83.2796,83.5415}, fillPattern = FillPattern.Solid, extent = {{-16.7204,-16.4585},{16.7204,16.4585}}, textString = "S", fontName = "Arial"),Text(visible = true, origin = {83.4635,83.6473}, fillPattern = FillPattern.Solid, extent = {{-16.5365,-16.3527},{16.5365,16.3527}}, textString = "P", fontName = "Arial"),Line(visible = true, origin = {3.235,5.733}, points = {{41.765,44.267},{8.38,-18.204},{-1.91,27.731},{-48.235,-53.794}}, color = {128,128,0}, thickness = 1),Line(visible = true, origin = {-36.0426,-31.3945}, points = {{16.054,3.333},{-8.957,-16.667},{-7.097,13.333}}, color = {128,128,0}, thickness = 1),Ellipse(visible = true, origin = {0.0,-0.625}, fillColor = {255,255,255}, extent = {{-79.375,-79.375},{79.375,79.375}})}), Diagram(coordinateSystem(extent = {{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10,10})));
end SinusNode;

