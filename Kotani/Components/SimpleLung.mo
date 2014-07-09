within Kotani.Components;
model SimpleLung
  Kotani.Components.Basic.RespiratoryPhase resp annotation(Placement(visible = true, transformation(origin = {0.0,-102.7206}, extent = {{-14.85,-10.5},{14.85,10.5}}, rotation = 0), iconTransformation(origin = {0.0,-97.8291}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
  Kotani.Components.Basic.Nerve baro annotation(Placement(visible = true, transformation(origin = {-147.9538,0.4341}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {-100.0,-0.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
  parameter Real Tresp = 3.5 "base duration of respiratory phase";
  parameter Real G = 0.2 "scaling factor for influence of baroreceptor afferents";
  parameter Real nu_trig = 1.3 "threshold for baroreceptor afferents";
  parameter Real initialR = 0 "initial value for resipratory phase";
  Real r "respiratory phase, (0 >= r > 0.5) means expiration, (0.5 >= r > 1) means inspiration";
initial equation
  r = initialR;
equation
  if r < 0.5 then
    der(r) = max(0, 1 / Tresp - max(0, G * (baro.activation - nu_trig))) "expiration";
  else
    der(r) = 1 / Tresp "inspiration";
  end if;
  when r > 1 then
    reinit(r, 0);
  end when;
  //resp.phase = cos(2 * Modelica.Constants.pi * r); //TODO either derive this equation manually or connect components directly w/o respiratory system
  resp.rate = 2*Modelica.Constants.pi*sin(2 * Modelica.Constants.pi * r) * der(r);
  //we do not change the activity of the baroreceptor
  baro.rate = 0;
  annotation(Icon(coordinateSystem(extent = {{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10,10}), graphics = {Ellipse(visible = true, origin = {31.429,0.0}, rotation = 100, fillColor = {0,255,255}, fillPattern = FillPattern.Solid, extent = {{-71.626,-26.5365},{71.626,26.5365}}),Ellipse(visible = true, origin = {-31.429,-0.0}, rotation = -100, fillColor = {0,255,255}, fillPattern = FillPattern.Solid, extent = {{71.626,-26.5365},{-71.626,26.5365}}),Polygon(visible = true, origin = {-84.206,21.29}, fillColor = {128,0,0}, fillPattern = FillPattern.Solid, points = {{-3.305,1.254},{-5.794,-1.633},{-5.794,-7.905},{-2.355,-11.29},{3.069,-11.29},{5.98,-7.905},{6.088,-1.789},{3.177,1.783},{2.119,8.398},{-0.28,14.904},{-1.188,9.72},{-1.718,5.752}}, smooth = Smooth.Bezier)}), Diagram(coordinateSystem(extent = {{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5,5})));
end SimpleLung;
