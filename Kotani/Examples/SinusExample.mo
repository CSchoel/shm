within Kotani.Examples;
model SinusExample
  Kotani.Components.Basic.NerveSystem nerveSystem1 annotation(Placement(visible = true, transformation(origin = {-60.0,60.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
  Kotani.Components.Basic.LinearNerveSignal linearNerveSignal1(topval = 10) annotation(Placement(visible = true, transformation(origin = {-110.0,65.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
  Kotani.Components.Basic.NerveSystem nerveSystem2 annotation(Placement(visible = true, transformation(origin = {15.0,50.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
  Kotani.Components.Basic.NerveSystem nerveSystem3 annotation(Placement(visible = true, transformation(origin = {-20.0,-20.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
  Kotani.Components.SinusNode sinusNode1 annotation(Placement(visible = true, transformation(origin = {-15.0,17.8768}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
  Kotani.Components.Basic.LinearNerveSignal linearNerveSignal2(t1 = 3, t2 = 4, topval = 0.1) annotation(Placement(visible = true, transformation(origin = {30.0,77.0404}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
equation
  connect(linearNerveSignal2.nerve1,nerveSystem2.fiber) annotation(Line(visible = true, origin = {22.0,63.2601}, points = {{8.0,13.7803},{8.0,-0.2601},{-8.0,-0.2601},{-8.0,-13.2601}}));
  connect(nerveSystem2.fiber,sinusNode1.parasympathicus) annotation(Line(visible = true, origin = {2.3525,33.8212}, points = {{11.6475,16.1788},{11.6475,-2.9444},{-11.6475,-2.9444},{-11.6475,-10.2899}}));
  connect(nerveSystem1.fiber,sinusNode1.sympathicus) annotation(Line(visible = true, origin = {-34.3757,41.7887}, points = {{-26.6243,18.2113},{6.3757,18.2113},{6.3757,-18.2113},{13.8728,-18.2113}}));
  connect(sinusNode1.phase,nerveSystem3.fiber) annotation(Line(visible = true, origin = {-18.0,-6.0308}, points = {{3.0,15.9076},{3.0,-0.9692},{-3.0,-0.9692},{-3.0,-13.9692}}));
  connect(linearNerveSignal1.nerve1,nerveSystem1.fiber) annotation(Line(visible = true, origin = {-79.3619,62.5}, points = {{-30.6381,2.5},{6.1381,2.5},{6.1381,-2.5},{18.3619,-2.5}}));
  annotation(Diagram(coordinateSystem(extent = {{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5,5})));
end SinusExample;

