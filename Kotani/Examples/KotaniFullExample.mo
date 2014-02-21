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
  Kotani.Components.NeurotransmitterEmission neurotransmitteremission1 annotation(Placement(visible = true, transformation(origin = {14.238,13.3482}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Kotani.Components.HormoneEmission hormoneemission1 annotation(Placement(visible = true, transformation(origin = {-5.33924,0.667451}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Kotani.Components.Basic.LinearNerveSignal linearnervesignal1 annotation(Placement(visible = true, transformation(origin = {-21.802,-80.089}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Kotani.Components.Basic.NerveSystem nervesystem4 annotation(Placement(visible = true, transformation(origin = {12.0133,-79.1991}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Kotani.Components.Basic.BloodSystem bloodsystem2 annotation(Placement(visible = true, transformation(origin = {-73.2143,-41.0714}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Kotani.Components.Basic.LinearBloodPressure linearbloodpressure1 annotation(Placement(visible = true, transformation(origin = {-77.6786,-65.1786}, extent = {{-10,-10},{10,10}}, rotation = 0)));
equation
  connect(baroreceptors1.artery,bloodsystem1.vessel) annotation(Line(points = {{-73.1924,-16.9077},{-44.1964,-16.9077},{-44.1964,-31.4732},{-31.6964,-31.4732},{-31.6964,-31.4732}}));
  connect(linearbloodpressure1.vessel,bloodsystem2.vessel) annotation(Line(points = {{-77.6786,-65.1786},{-83.7054,-65.1786},{-83.7054,-40.8482},{-83.7054,-40.8482}}));
  connect(nervesystem4.fiber,hormoneemission1.trigger) annotation(Line(points = {{11.0133,-79.1991},{10.2336,-79.1991},{10.2336,-16.6852},{-5.33927,-16.6852},{-5.33927,-5.33927},{-5.33927,-5.33927}}));
  connect(linearnervesignal1.nerve1,nervesystem4.fiber) annotation(Line(points = {{-21.802,-80.089},{12.0133,-80.089},{12.0133,-79.644},{12.0133,-79.644}}));
  connect(hormoneemission1.con,heart1.cvne) annotation(Line(points = {{-5.50924,5.83745},{37.3749,5.83745},{37.3749,0.222469},{38.0423,0.222469},{38.0423,0.222469}}));
  connect(neurotransmitteremission1.con,heart1.ccne) annotation(Line(points = {{14.068,18.5182},{24.0267,18.5182},{24.0267,-31.8131},{64.2937,-31.8131},{64.2937,0.444939},{54.9499,0.444939},{54.9499,0.444939}}));
  connect(neurotransmitteremission1.con,sinusnode1.ccne) annotation(Line(points = {{14.068,18.5182},{36.9299,18.5182},{36.9299,21.5795},{36.9299,21.5795}}));
  connect(nervesystem2.fiber,neurotransmitteremission1.trigger) annotation(Line(points = {{-33.4805,15.3504},{3.33704,15.3504},{3.33704,8.23137},{13.5706,8.23137},{13.5706,8.23137}}));
  connect(parasympatheticsystem1.baro,nervesystem1.fiber) annotation(Line(points = {{-5.55061,42.9366},{-24.9166,42.9366},{-24.9166,24.9166},{-70.0779,24.9166},{-70.0779,55.1724},{-70.0779,55.1724}}));
  connect(nervesystem1.fiber,simplelung1.baro) annotation(Line(points = {{-69.5206,56.0623},{-47.1635,56.0623},{-47.1635,86.3181},{-24.9166,86.3181},{-24.9166,85.8732},{-24.9166,85.8732}}));
  connect(nervesystem1.fiber,sympatheticsystem1.baro) annotation(Line(points = {{-69.5206,56.0623},{-57.1746,56.0623},{-57.1746,41.3793},{-49.3882,41.3793},{-49.3882,41.3793}}));
  connect(baroreceptors1.signal,nervesystem1.fiber) annotation(Line(points = {{-73.1924,-6.90768},{-83.2036,-6.90768},{-83.2036,56.0623},{-69.188,56.0623},{-69.188,56.0623}}));
  connect(bloodsystem1.vessel,heart1.artery) annotation(Line(points = {{-31.802,-31.3682},{-36.7075,-31.3682},{-36.7075,-10.0111},{36.9299,-10.0111},{36.9299,-10.0111}}));
  connect(sympatheticsystem1.signal,nervesystem2.fiber) annotation(Line(points = {{-38.7097,31.8242},{-46.0512,31.8242},{-46.0512,14.9055},{-33.1479,14.9055},{-33.1479,14.9055}}));
  connect(nervesystem3.fiber,sinusnode1.parasympathicus) annotation(Line(points = {{38.822,52.0578},{51.8354,52.0578},{51.8354,26.9188},{51.8354,26.9188}}));
  connect(parasympatheticsystem1.signal,nervesystem3.fiber) annotation(Line(points = {{4.44939,32.9366},{4.44939,32.9366},{4.44939,28.6986},{22.6919,28.6986},{22.6919,52.0578},{38.0423,52.0578},{38.0423,52.0578}}));
  connect(respiratorysystem1.phase,parasympatheticsystem1.resp) annotation(Line(points = {{-25.7953,58.287},{-25.8065,58.287},{-25.8065,69.6329},{4.22692,69.6329},{4.22692,52.7253},{4.22692,52.7253}}));
  connect(respiratorysystem1.phase,sympatheticsystem1.resp) annotation(Line(points = {{-25.7953,58.287},{-38.7097,58.287},{-38.7097,52.0578},{-38.7097,52.0578}}));
  connect(respiratorysystem1.phase,simplelung1.resp) annotation(Line(points = {{-25.7953,58.287},{-28.921,58.287},{-28.921,71.4127},{-14.683,71.4127},{-14.683,76.7519},{-14.683,76.7519}}));
  connect(sinusnode1.signal,heart1.sinusSignal) annotation(Line(points = {{46.5183,11.6351},{46.7186,11.6351},{46.7186,-0.113053},{46.6563,-0.113053}}));
  annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), experiment(StartTime = 0, StopTime = 10, Tolerance = 0.000001));
end KotaniFullExample;

