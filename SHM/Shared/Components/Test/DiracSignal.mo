within SHM.Shared.Components.Test;
model DiracSignal "Discrete periodic dirac signal"
  SHM.Shared.Connectors.ExcitationOutput signal "the generated signal" annotation(Placement(visible = true, transformation(origin = {98.8129,-39.9457}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {97.2839,-39.3723}, extent = {{-10,-10},{10,10}}, rotation = 0)));
equation
  signal = sample(0, 1);
  annotation(Icon(coordinateSystem(extent = {{-101.7,-51.7},{101.7,51.7}}), graphics = {Line(points = {{-80,-40},{-40,-40},{-40,50},{-40,-40},{6.7,-40},{6.7,50},{6.7,-40},{50,-40},{50,53.3},{50,-40},{93.3,-40}}, color = {0,0,0})}), experiment(StopTime = 1, StartTime = 0));
annotation(Documentation(info="<html><p>Generates a discrete dirac signal every second.</p></html>"));
end DiracSignal;
