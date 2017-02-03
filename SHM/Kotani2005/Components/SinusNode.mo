within SHM.Kotani2005.Components;
model SinusNode "sinus node integrate-and-fire model"
  SHM.Shared.Connectors.ExcitationOutput signal "generated signal" annotation(Placement(visible = true, transformation(origin = {0, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SHM.Shared.Connectors.NerveInput parasympathicus "parasympathetic input signal" annotation(Placement(visible = true, transformation(origin = {40, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {40, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SHM.Shared.Connectors.NeurotransmitterConcentration ccne "Cardiac Concentration of Norepinephrine" annotation(Placement(visible = true, transformation(origin = {-40, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-40, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Real phase "phase for integrate-and-fire; when this variable reaches a value greater than 1, the sinus node fires";
  Real rate "rate of the integrate-and-fire phase";
  parameter Real T0 = 0.6 "base rate at which sinus node fires without input from central nervous system";
  parameter Real sfsym = 1.6 "scaling factor for sympathetic influence on sinus node";
  parameter Real symDelay = 1.65 "time taken for sympathetic neural activity to trigger release of cardiac Norepinephrine";
  parameter Real paraDelay = 0.5 "time taken for a neural signal from the parasympathetic system to reach the sinus node";
  parameter Real paraMax = 2.5 "saturation value for the parasympathetic neural activity at the sinus node";
  parameter Real paraSatexp = 2 "saturation speed (exponent) of parasympathetic neural activity at the sinus node";
  parameter Real sfpara = 5.8 "sensitivity of the sinus node to parasympathetic activity";
  parameter Real ccneSatexp = 2 "saturation speed (exponend) of cardiac concentration of Norepinephrine";
  parameter Real ccneMax = 2 "saturation value for the cardiac concentration of Norepinephrine";
  parameter Real initialPhase = 0 "initial value for the integrate-and-fire phase";
  SHM.Shared.Components.Saturation satPara(sat=paraMax,satexp=paraSatexp) "saturation function for parasympathetic system";
  SHM.Shared.Components.Saturation satCcne(sat=ccneMax,satexp=ccneSatexp) "saturation function for cardiac concentration of Norepinephrine";
  Real fs "sympathetic influence on sinus node";
  Real fp "parasympathetic influence on sinus node";
  Boolean signal0(start = false, fixed = true) "switches values on each heartbeat (used to propagate heartbeat event)";
initial equation
  phase = initialPhase;
equation
  rate = der(phase);
  satCcne.x = ccne.concentration;
  satPara.x = delay(parasympathicus.activation, paraDelay, paraDelay);
  fs = 1 + sfsym * satCcne.satx;
  fp = 1 - sfpara * satPara.satx;
  rate = 1 / T0 * fs * fp;
  when phase > 1 then
    reinit(phase, 0);
    signal0 = not pre(signal0);
  end when;
  signal = change(signal0);
  //we do not change the input signals
  ccne.rate = 0;
annotation(Documentation(info="<html>
  <p>Models sinus node as integrate-and-fire system.</p>
  <p>Influence of parasympathetic is modeled directly, because Acetylcholine has faster kinetics than Norepinephrine, which is modeled explicitly as concentration.</p>
</html>"), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {1, 1})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {1, 1}), graphics = {Ellipse(origin = {-0.158344, 0.48068}, fillColor = {255, 255, 255}, extent = {{-79.375, -79.375}, {79.375, 79.375}}, endAngle = 360), Line(origin = {-2.27393, 7.79068}, points = {{-71.3692, -24.1544}, {-38.0955, 24.8617}, {-38.0955, -25.2277}, {-7.68408, 24.8617}, {-7.68408, -25.2277}, {22.0118, 24.8617}, {22.0118, -23.7966}, {52.4233, 25.2195}, {52.4233, -24.5122}, {71.3857, 6.97263}}, thickness = 2), Line(origin = {-22.2939, -49.6393}, points = {{-18.4258, 25.7603}, {-18.4258, -3.9356}, {22.1482, -3.9356}, {22.2592, -21.3519}}, pattern = LinePattern.Dash, thickness = 1, arrow = {Arrow.None, Arrow.Filled}), Line(origin = {-32.8383, -21.0004}, points = {{5.44247, 5.65551}, {0.63654, -2.22572}, {0.17224, 3.65356}, {-4.67192, -4.67192}}, color = {255, 170, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 4), Line(origin = {5.25607, 42.6607}, points = {{-14.8479, 0}, {14.8479, 0}}, thickness = 1), Line(origin = {20.0961, 42.6336}, points = {{0, 5.72451}, {0, -5.72451}}, thickness = 1), Line(origin = {-9.6177, 42.645}, points = {{0, 5.72451}, {0, -5.72451}}, thickness = 1), Line(origin = {-18.929, 56.5985}, points = {{-16.192, 10.3216}, {16.192, -10.3216}}, thickness = 1, arrow = {Arrow.None, Arrow.Filled}), Line(origin = {20.1661, 56.4707}, points = {{9.35393, 9.41844}, {-9.35393, -9.41844}}, thickness = 1, arrow = {Arrow.None, Arrow.Filled}), Text(origin = {9.26117, 59.1162}, extent = {{-5.16, 4.45}, {10.9659, -9.09471}}, textString = "+"), Text(origin = {-6.47333, 58.0636}, extent = {{-5.16, 4.45}, {10.97, -9.09}}, textString = "-")}));
end SinusNode;
