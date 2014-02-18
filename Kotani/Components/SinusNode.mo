within Kotani.Components;
model SinusNode "SinusNode"
  Kotani.Components.Basic.Nerve parasympathicus annotation(Placement(transformation(origin = {100,100}, extent = {{-10,-10},{10,10}}), iconTransformation(origin = {50,50}, extent = {{-10,-10},{10,10}})));
  Kotani.Components.Basic.Nerve phase annotation(Placement(transformation(origin = {-54.9,-74.8}, extent = {{-10,-10},{10,10}}), iconTransformation(origin = {0,-100}, extent = {{-10,-10},{10,10}})));
  Kotani.Components.Basic.HormoneConcentration ccne "Cardiac Concentration of Norepinephrine" annotation(Placement(transformation(origin = {-139.9,9.9}, extent = {{-10,-10},{10,10}}), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}})));
  parameter Real T0 = 0.6 "base rate at which sinus node fires without input from central nervous system";
  parameter Real sfsym = 1.6 "scaling factor for sympathetic influence on sinus node";
  parameter Real symDelay = 1.65 "time taken for sympathetic neural activity to trigger release of cardiac Norepinephrine";
  parameter Real paraDelay = 0.5 "time taken for a neural signal from the parasympathetic system to reach the sinus node";
  parameter Real paraMax = 2.5 "saturation value for the parasympathetic neural activity at the sinus node";
  parameter Real paraSatexp = 2 "saturation speed (exponent) of parasympathetic neural activity at the sinus node";
  parameter Real sfpara = 5.8 "sensitivity of the sinus node to parasympathetic activity";
  Kotani.Components.Basic.Saturation satPara;
  Real fs "sympathetic influence on sinus node";
  Real ps "parasympathetic influence on sinus node";
equation
  satPara.satexp = paraSatexp;
  satPara.sat = paraMax;
  satPara.x = delay(parasympathicus.activation, paraDelay, paraDelay);
  fs = 1 + sfsym * ccne.concentration;
  ps = 1 - sfpara * satPara.satx;
  phase.rate = 1 / T0 * fs * ps;
  when phase.activation > 1 then
      reinit(phase.activation, 0);
  
  end when;
  annotation(Icon(coordinateSystem(grid = {10,10}), graphics = {Text(textString = "S", fillPattern = FillPattern.Solid, extent = {{-16.7204,-16.4585},{16.7204,16.4585}}, visible = true, origin = {-83.2796,83.5415}),Text(textString = "P", fillPattern = FillPattern.Solid, extent = {{-16.5365,-16.3527},{16.5365,16.3527}}, visible = true, origin = {83.4635,83.6473}),Line(points = {{41.765,44.267},{8.38,-18.204},{-1.91,27.731},{-48.235,-53.794}}, color = {128,128,0}, thickness = 1, visible = true, origin = {3.2,-14.1}),Line(points = {{16.054,3.333},{-8.957,-16.667},{-7.097,13.333}}, color = {128,128,0}, thickness = 1, visible = true, origin = {-36,-51.2}),Ellipse(fillColor = {255,255,255}, extent = {{-79.375,-79.375},{79.375,79.375}}, visible = true, origin = {0.8,-10.7})}), Diagram(coordinateSystem(grid = {10,10}), graphics = {Rectangle(lineColor = {0,0,0}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, extent = {{-85,80},{-25,35}})}), experiment(StopTime = 1, StartTime = 0));
end SinusNode;

