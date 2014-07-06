within Kotani.Examples;
model SinusExample
  Components.Basic.NerveSystem nerveSystem1 annotation(Placement(transformation(origin = {-60,60}, extent = {{-10,-10},{10,10}})));
  Components.Basic.LinearNerveSignal linearNerveSignal1(rate = 10) annotation(Placement(transformation(origin = {-110,65}, extent = {{-10,-10},{10,10}})));
  Components.Basic.NerveSystem nerveSystem2 annotation(Placement(transformation(origin = {15,50}, extent = {{-10,-10},{10,10}})));
  Components.SinusNode sinusNode1 annotation(Placement(transformation(origin = {-15,17.8768}, extent = {{-10,-10},{10,10}})));
  Components.Basic.LinearNerveSignal linearNerveSignal2(t1 = 3, t2 = 4, rate = 0.1) annotation(Placement(transformation(origin = {30,77.0404}, extent = {{-10,-10},{10,10}})));
  Components.HormoneEmission hormoneEmission1;
  Kotani.Components.NeurotransmitterEmission neurotransmitteremission1 annotation(Placement(visible = true, transformation(origin = {-44.0625,26.7188}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Kotani.Components.Basic.NeurotransmitterAmount neurotransmitteramount1 annotation(Placement(visible = true, transformation(origin = {-33.9844,45.7031}, extent = {{-10,-10},{10,10}}, rotation = 0)));
equation
  connect(sinusNode1.ccne,neurotransmitteramount1.con) annotation(Line(points = {{-25,17.8768},{-33.0469,17.8768},{-33.0469,42.4219},{-33.0469,42.4219}}));
  connect(neurotransmitteremission1.con,neurotransmitteramount1.con) annotation(Line(points = {{-44.2325,31.8888},{-36.3281,31.8888},{-36.3281,41.0156},{-36.3281,41.0156}}));
  connect(nerveSystem1.fiber,neurotransmitteremission1.trigger) annotation(Line(points = {{-61,60},{-60.9375,60},{-60.9375,9.84375},{-44.5312,9.84375},{-44.5312,22.2656},{-44.5312,22.2656}}));
  connect(linearNerveSignal1.nerve1,nerveSystem1.fiber) annotation(Line(points = {{-110.2,65},{-115.2,65},{-115.2,55},{-65.8,55},{-65.8,60},{-60.8,60}}, thickness = 0.0625));
  connect(nerveSystem2.fiber,sinusNode1.parasympathicus) annotation(Line(points = {{14.2,50},{9.2,50},{-10.2,50},{-10.2,28},{-10.2,23}}, thickness = 0.0625));
  connect(linearNerveSignal2.nerve1,nerveSystem2.fiber) annotation(Line(points = {{29.8,77},{24.8,77},{9.2,77},{9.2,50},{14.2,50}}, thickness = 0.0625));
  connect(hormoneEmission1.trigger,nerveSystem1.fiber) annotation(Line(points = {{-43.5,40},{-48.5,35},{-58.5,35},{-58.5,60},{-60.83332824707031,60}}, thickness = 0.0625), AutoRoute = false);
  annotation(sinusNode1(phase(activation(flags = 2))), Diagram(coordinateSystem(extent = {{-148.5,-105},{148.5,105}}, grid = {5,5})), experiment(StartTime = 0, StopTime = 10, Tolerance = 0.000001));
end SinusExample;

