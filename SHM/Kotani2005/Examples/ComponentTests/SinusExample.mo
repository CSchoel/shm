within SHM.Kotani2005.Examples.ComponentTests;
model SinusExample "sinus node test"
  SHM.Shared.Components.Test.LinearNerveSignal linearNerveSignal1(topval = 10) "cCne trigger signal" annotation(Placement(transformation(origin = {-110,65}, extent = {{-10,-10},{10,10}})));
  SHM.Shared.Components.Test.LinearNerveSignal linearNerveSignal2(t1 = 3, t2 = 4, topval = 0.1) "cVne trigger signal" annotation(Placement(transformation(origin = {30,77.0404}, extent = {{-10,-10},{10,10}})));
  SHM.Kotani2005.Components.SinusNode sinusNode1 "sinus node" annotation(Placement(transformation(origin = {-15,17.8768}, extent = {{-10,-10},{10,10}})));
  SHM.Kotani2005.Components.HormoneRelease HormoneRelease1 "cVne emission";
  SHM.Kotani2005.Components.NeurotransmitterEmission neurotransmitteremission1 "cCne emission" annotation(Placement(visible = true, transformation(origin = {-44.0625,26.7188}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  SHM.Shared.Components.Compartments.NeurotransmitterAmount neurotransmitteramount1 "cCne amount" annotation(Placement(visible = true, transformation(origin = {-33.9844,45.7031}, extent = {{-10,-10},{10,10}}, rotation = 0)));
equation
  connect(sinusNode1.ccne,neurotransmitteramount1.con) annotation(Line(points = {{-25,17.8768},{-33.0469,17.8768},{-33.0469,42.4219},{-33.0469,42.4219}}));
  connect(neurotransmitteremission1.con,neurotransmitteramount1.con) annotation(Line(points = {{-44.2325,31.8888},{-36.3281,31.8888},{-36.3281,41.0156},{-36.3281,41.0156}}));
  connect(linearNerveSignal1.nerve1,neurotransmitteremission1.trigger) annotation(Line(points = {{-61,60},{-60.9375,60},{-60.9375,9.84375},{-44.5312,9.84375},{-44.5312,22.2656},{-44.5312,22.2656}}));
  connect(linearNerveSignal1,sinusNode1.parasympathicus) annotation(Line(points = {{14.2,50},{9.2,50},{-10.2,50},{-10.2,28},{-10.2,23}}, thickness = 0.0625));
  connect(linearNerveSignal2.nerve1,HormoneRelease1.trigger) annotation(Line(points = {{-43.5,40},{-48.5,35},{-58.5,35},{-58.5,60},{-60.83332824707031,60}}, thickness = 0.0625), AutoRoute = false);
  annotation(sinusNode1(phase(activation(flags = 2))), Diagram(coordinateSystem(extent = {{-148.5,-105},{148.5,105}}, grid = {5,5})), experiment(StartTime = 0, StopTime = 10, Tolerance = 0.000001));
annotation(Documentation(info="<html>
  <p>Models small test system with substance emissions and sinus node.</p>
</html>"));
end SinusExample;

