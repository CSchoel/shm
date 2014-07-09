within Kotani.Components.Basic;
model FiringNerve "FiringNerve"
  NerveOutput nerve1 annotation(Placement(transformation(extent = {{-150,30},{-130,50}}), iconTransformation(extent = {{-111.7,-8.3},{-91.7,11.7}})));
protected
  Real ts(start = 1);
equation
  /*when time >= pre(ts) then
      nerve1.activation = time;
    ts = time + 1;
  
  end when;*/
  ts = time;
  nerve1.activation = if sample(0, 1) then 1 else 0;
  annotation(Icon(coordinateSystem(extent = {{-101.7,-51.7},{101.7,51.7}}), graphics = {Line(points = {{-80,-40},{-40,-40},{-40,50},{-40,-40},{6.7,-40},{6.7,50},{6.7,-40},{50,-40},{50,53.3},{50,-40},{93.3,-40}}, color = {0,0,0})}), experiment(StopTime = 1, StartTime = 0));
end FiringNerve;

