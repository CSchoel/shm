within Kotani.Components.Basic;
model DiracSignal "Discrete periodic dirac signal"
  Kotani.Components.Basic.DiscreteSignal signal annotation(Placement(visible = true, transformation(origin = {98.8129,-39.9457}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {97.2839,-39.3723}, extent = {{-10,-10},{10,10}}, rotation = 0)));
equation
  signal.s = if sample(0, 1) then 1 else 0;
  annotation(Icon(coordinateSystem(extent = {{-101.7,-51.7},{101.7,51.7}}), graphics = {Line(points = {{-80,-40},{-40,-40},{-40,50},{-40,-40},{6.7,-40},{6.7,50},{6.7,-40},{50,-40},{50,53.3},{50,-40},{93.3,-40}}, color = {0,0,0})}), experiment(StopTime = 1, StartTime = 0));
end DiracSignal;

