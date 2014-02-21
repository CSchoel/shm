within Kotani.Components;
model SinusNode "SinusNode"
  Kotani.Components.Basic.Nerve parasympathicus annotation(Placement(transformation(origin = {100,100}, extent = {{-10,-10},{10,10}}), iconTransformation(origin = {50,50}, extent = {{-10,-10},{10,10}})));
  Real phase(start = 0);
  Real rate(start = 0);
  Kotani.Components.Basic.NeurotransmitterConcentration ccne "Cardiac Concentration of Norepinephrine" annotation(Placement(transformation(origin = {-139.9,9.9}, extent = {{-10,-10},{10,10}}), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}})));
  parameter Real T0 = 0.6 "base rate at which sinus node fires without input from central nervous system";
  parameter Real sfsym = 1.6 "scaling factor for sympathetic influence on sinus node";
  parameter Real symDelay = 1.65 "time taken for sympathetic neural activity to trigger release of cardiac Norepinephrine";
  parameter Real paraDelay = 0.5 "time taken for a neural signal from the parasympathetic system to reach the sinus node";
  parameter Real paraMax = 2.5 "saturation value for the parasympathetic neural activity at the sinus node";
  parameter Real paraSatexp = 2 "saturation speed (exponent) of parasympathetic neural activity at the sinus node";
  parameter Real sfpara = 5.8 "sensitivity of the sinus node to parasympathetic activity";
  parameter Real ccneSatexp = 2 "saturation speed (exponend) of cardiac concentration of Norepinephrine";
  parameter Real ccneMax = 2 "saturation value for the cardiac concentration of Norepinephrine";
  Kotani.Components.Basic.Saturation satPara;
  Kotani.Components.Basic.Saturation satCcne;
  Real fs "sympathetic influence on sinus node";
  Real ps "parasympathetic influence on sinus node";
  Kotani.Components.Basic.DiscreteSignal signal annotation(Placement(visible = true, transformation(origin = {-1.33482,-86.0957}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {0.222469,-101.669}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Boolean signal0(start = false) "switches values on each heartbeat (used to propagate heartbeat event)";
equation
  rate = der(phase);
  satCcne.satexp = ccneSatexp;
  satCcne.sat = ccneMax;
  satCcne.x = ccne.concentration;
  satPara.satexp = paraSatexp;
  satPara.sat = paraMax;
  satPara.x = delay(parasympathicus.activation, paraDelay, paraDelay);
  fs = 1 + sfsym * satCcne.satx;
  ps = 1 - sfpara * satPara.satx;
  rate = 1 / T0 * fs * ps;
  when phase > 1 then
      reinit(phase, 0);
    signal0 = not pre(signal0);
  
  end when;
  //need to use phase.activation == 0 because the when clause voids the event phase.activation > 1
  signal.s = if change(signal0) then 1 else 0;
  //we do not change the input signals
  parasympathicus.rate = 0;
  ccne.rate = 0;
  annotation(Icon(coordinateSystem(grid = {10,10}), graphics = {Text(textString = "S", fillPattern = FillPattern.Solid, extent = {{-16.7204,-16.4585},{16.7204,16.4585}}, visible = true, origin = {-83.2796,83.5415}),Text(textString = "P", fillPattern = FillPattern.Solid, extent = {{-16.5365,-16.3527},{16.5365,16.3527}}, visible = true, origin = {83.4635,83.6473}),Line(points = {{41.765,44.267},{8.38,-18.204},{-1.91,27.731},{-48.235,-53.794}}, color = {128,128,0}, thickness = 1, visible = true, origin = {3.2,-14.1}),Line(points = {{16.054,3.333},{-8.957,-16.667},{-7.097,13.333}}, color = {128,128,0}, thickness = 1, visible = true, origin = {-36,-51.2}),Ellipse(fillColor = {255,255,255}, extent = {{-79.375,-79.375},{79.375,79.375}}, visible = true, origin = {0.8,-10.7})}), Diagram(coordinateSystem(grid = {10,10}), graphics = {Rectangle(lineColor = {0,0,0}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, extent = {{-85,80},{-25,35}})}), experiment(StopTime = 1, StartTime = 0));
end SinusNode;

