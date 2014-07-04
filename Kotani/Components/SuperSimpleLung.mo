within Kotani.Components;
model SuperSimpleLung
  Kotani.Components.Basic.RespiratoryPhase resp annotation(Placement(visible = true, transformation(origin = {0.0,-102.7206}, extent = {{-14.85,-10.5},{14.85,10.5}}, rotation = 0), iconTransformation(origin = {0.0,-97.8291}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
  Kotani.Components.Basic.Nerve baro annotation(Placement(visible = true, transformation(origin = {-147.9538,0.4341}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {-100.0,-0.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
  parameter Real Tresp = 3.5 "base duration of respiratory phase";
  parameter Real G = 0.2 "scaling factor for influence of baroreceptor afferents";
  parameter Real nu_trig = 1.3 "threshold for baroreceptor afferents";
  Real r;
protected
  Real t0(start = 0);
equation
  when r > 1 or initial() then
    t0 = time;
  end when;
  r = (time - t0) * 1 / Tresp;
  resp.phase = cos(2 * Modelica.Constants.pi * r);
  annotation(__Wolfram(itemFlippingEnabled = true), Icon(coordinateSystem(extent = {{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10,10}), graphics = {Ellipse(visible = true, origin = {31.429,0.0}, rotation = 100, fillColor = {0,255,255}, fillPattern = FillPattern.Solid, extent = {{-71.626,-26.5365},{71.626,26.5365}}),Ellipse(visible = true, origin = {-31.429,-0.0}, rotation = -100, fillColor = {0,255,255}, fillPattern = FillPattern.Solid, extent = {{71.626,-26.5365},{-71.626,26.5365}}),Polygon(visible = true, origin = {-84.206,21.29}, fillColor = {128,0,0}, fillPattern = FillPattern.Solid, points = {{-3.305,1.254},{-5.794,-1.633},{-5.794,-7.905},{-2.355,-11.29},{3.069,-11.29},{5.98,-7.905},{6.088,-1.789},{3.177,1.783},{2.119,8.398},{-0.28,14.904},{-1.188,9.72},{-1.718,5.752}}, smooth = Smooth.Bezier)}), Diagram(coordinateSystem(extent = {{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5,5})));
end SuperSimpleLung;
