within Kotani.Components.Basic;
connector TestConnector "NewConnector1"
  Real testvar "Variable";
  annotation(Icon(graphics = {Rectangle(lineColor = {0,0,0}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, extent = {{-80,90},{0,-83.3}}),Polygon(points = {{-76.5,-3.5},{-29.8,83.2},{53.5,46.5},{56.9,-53.5},{-36.5,-70.1},{-63.1,-40.1},{-13.3,9.9}}, lineColor = {0,0,0}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Line(points = {{40,80},{86.7,-23.3},{0,20},{83.3,-106.7}}, color = {0,0,0}),Line(points = {{-86.7,23.3},{-30,63.3},{-43.3,-26.7},{13.3,66.7},{-13.3,-80},{90,-56.7}}, color = {0,0,0}, smooth = Smooth.Bezier)}));
end TestConnector;

