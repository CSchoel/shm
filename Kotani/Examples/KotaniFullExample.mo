within Kotani.Examples;
model KotaniFullExample
  Kotani.Components.SimpleLung simplelung1 annotation(Placement(visible = true, transformation(origin = {-14.4605,86.5406}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Kotani.Components.Heart heart1 annotation(Placement(visible = true, transformation(origin = {46.941,-9.78865}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Kotani.Components.SinusNode sinusnode1 annotation(Placement(visible = true, transformation(origin = {46.4961,21.802}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Kotani.Components.ParasympatheticSystem parasympatheticsystem1 annotation(Placement(visible = true, transformation(origin = {4.44939,42.9366}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Kotani.Components.SympatheticSystem sympatheticsystem1 annotation(Placement(visible = true, transformation(origin = {-38.7097,41.8242}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Kotani.Components.Basic.RespiratorySystem respiratorysystem1 annotation(Placement(visible = true, transformation(origin = {-15.7953,58.287}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Kotani.Components.Basic.NerveSystem nervesystem1 annotation(Placement(visible = true, transformation(origin = {-68.5206,56.0623}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Kotani.Components.Baroreceptors baroreceptors1 annotation(Placement(visible = true, transformation(origin = {-73.1924,-16.9077}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Kotani.Components.Basic.BloodSystem bloodsystem1 annotation(Placement(visible = true, transformation(origin = {-21.802,-31.3682}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Kotani.Components.Basic.NerveSystem nervesystem2 annotation(Placement(visible = true, transformation(origin = {-32.4805,15.3504}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Kotani.Components.Basic.NerveSystem nervesystem3 annotation(Placement(visible = true, transformation(origin = {39.822,52.0578}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Kotani.Components.NeurotransmitterEmission neurotransmitteremission1 annotation(Placement(visible = true, transformation(origin = {-2.00222,8.67631}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Kotani.Components.HormoneEmission hormoneemission1 annotation(Placement(visible = true, transformation(origin = {16.9077,-33.1479}, extent = {{-10,-10},{10,10}}, rotation = 0)));
equation
  connect(parasympatheticsystem1.baro,nervesystem1.fiber) annotation(Line(points = {{-5.55061,42.9366},{-24.9166,42.9366},{-24.9166,24.9166},{-70.0779,24.9166},{-70.0779,55.1724},{-70.0779,55.1724}}));
  connect(nervesystem1.fiber,simplelung1.baro) annotation(Line(points = {{-69.5206,56.0623},{-47.1635,56.0623},{-47.1635,86.3181},{-24.9166,86.3181},{-24.9166,85.8732},{-24.9166,85.8732}}));
  connect(nervesystem1.fiber,sympatheticsystem1.baro) annotation(Line(points = {{-69.5206,56.0623},{-57.1746,56.0623},{-57.1746,41.3793},{-49.3882,41.3793},{-49.3882,41.3793}}));
  connect(hormoneemission1.con,heart1.ccne) annotation(Line(points = {{16.7377,-27.9779},{67.8532,-27.9779},{67.8532,0.444939},{55.1724,0.444939},{55.1724,0.444939}}));
  connect(nervesystem2.fiber,hormoneemission1.trigger) annotation(Line(points = {{-33.4805,15.3504},{-33.5929,15.3504},{-33.5929,-5.7842},{2.44716,-5.7842},{2.44716,-38.2647},{16.4627,-38.2647},{16.4627,-38.2647}}));
  connect(neurotransmitteremission1.con,heart1.cvne) annotation(Line(points = {{-2.17222,13.8463},{26.0289,13.8463},{26.0289,0.444939},{38.0423,0.444939},{38.0423,0},{38.0423,0}}));
  connect(baroreceptors1.signal,nervesystem1.fiber) annotation(Line(points = {{-73.1924,-6.90768},{-83.2036,-6.90768},{-83.2036,56.0623},{-69.188,56.0623},{-69.188,56.0623}}));
  connect(bloodsystem1.vessel,heart1.artery) annotation(Line(points = {{-31.802,-31.3682},{-36.7075,-31.3682},{-36.7075,-10.0111},{36.9299,-10.0111},{36.9299,-10.0111}}));
  connect(bloodsystem1.vessel,baroreceptors1.artery) annotation(Line(points = {{-31.802,-31.3682},{-50.9455,-31.3682},{-50.9455,-16.6852},{-69.6329,-16.6852},{-69.6329,-16.6852}}));
  connect(neurotransmitteremission1.con,sinusnode1.ccne) annotation(Line(points = {{-2.17222,13.8463},{9.12125,13.8463},{9.12125,21.802},{36.2625,21.802},{36.2625,21.802}}));
  connect(neurotransmitteremission1.trigger,nervesystem2.fiber) annotation(Line(points = {{-2.17222,3.84631},{-33.5929,3.84631},{-33.5929,15.1279},{-33.5929,15.1279}}));
  connect(sympatheticsystem1.signal,nervesystem2.fiber) annotation(Line(points = {{-38.7097,31.8242},{-46.0512,31.8242},{-46.0512,14.9055},{-33.1479,14.9055},{-33.1479,14.9055}}));
  connect(nervesystem3.fiber,sinusnode1.parasympathicus) annotation(Line(points = {{38.822,52.0578},{51.8354,52.0578},{51.8354,26.9188},{51.8354,26.9188}}));
  connect(parasympatheticsystem1.signal,nervesystem3.fiber) annotation(Line(points = {{4.44939,32.9366},{4.44939,32.9366},{4.44939,28.6986},{22.6919,28.6986},{22.6919,52.0578},{38.0423,52.0578},{38.0423,52.0578}}));
  connect(respiratorysystem1.phase,parasympatheticsystem1.resp) annotation(Line(points = {{-25.7953,58.287},{-25.8065,58.287},{-25.8065,69.6329},{4.22692,69.6329},{4.22692,52.7253},{4.22692,52.7253}}));
  connect(respiratorysystem1.phase,sympatheticsystem1.resp) annotation(Line(points = {{-25.7953,58.287},{-38.7097,58.287},{-38.7097,52.0578},{-38.7097,52.0578}}));
  connect(respiratorysystem1.phase,simplelung1.resp) annotation(Line(points = {{-25.7953,58.287},{-28.921,58.287},{-28.921,71.4127},{-14.683,71.4127},{-14.683,76.7519},{-14.683,76.7519}}));
  connect(sinusnode1.signal,heart1.sinusSignal) annotation(Line(points = {{46.5183,11.6351},{46.7186,11.6351},{46.7186,-0.113053},{46.6563,-0.113053}}));
  annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
end KotaniFullExample;

