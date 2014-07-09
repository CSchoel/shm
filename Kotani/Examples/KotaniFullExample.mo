within Kotani.Examples;

model KotaniFullExample
  Kotani.Components.SimpleLung simplelung1 annotation(Placement(visible = true, transformation(origin = {-14.4605, 86.5406}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Kotani.Components.Heart heart1 annotation(Placement(visible = true, transformation(origin = {46.941, -9.78865}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Kotani.Components.SinusNode sinusnode1 annotation(Placement(visible = true, transformation(origin = {46.4961, 21.802}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Kotani.Components.ParasympatheticSystem parasympatheticsystem1 annotation(Placement(visible = true, transformation(origin = {4.44939, 42.9366}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Kotani.Components.SympatheticSystem sympatheticsystem1 annotation(Placement(visible = true, transformation(origin = {-38.7097, 41.8242}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Kotani.Components.Baroreceptors baroreceptors1 annotation(Placement(visible = true, transformation(origin = {-73.1924, -16.9077}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Kotani.Components.Basic.BloodSystem bloodsystem1 annotation(Placement(visible = true, transformation(origin = {-21.802, -31.3682}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Kotani.Components.NeurotransmitterEmission neurotransmitteremission1 annotation(Placement(visible = true, transformation(origin = {14.238, 13.3482}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Kotani.Components.HormoneEmission hormoneemission1 annotation(Placement(visible = true, transformation(origin = {-5.33924, 0.667451}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Kotani.Components.Basic.NeurotransmitterAmount neurotransmitteramount1 annotation(Placement(visible = true, transformation(origin = {26.5848, 18.2813}, extent = {{-2.87946, -2.87946}, {2.87946, 2.87946}}, rotation = 0)));
  Kotani.Components.Basic.HormoneAmout hormoneamout1 annotation(Placement(visible = true, transformation(origin = {19.442, 2.65625}, extent = {{-3.10268, -3.10268}, {3.10268, 3.10268}}, rotation = 0)));
equation
  connect(simplelung1.resp, parasympatheticsystem1.resp) annotation(Line(points = {{-14.4605, 76.7577}, {5.36673, 76.7577}, {5.36673, 52.9517}, {5.36673, 52.9517}}));
  connect(simplelung1.resp, sympatheticsystem1.resp) annotation(Line(points = {{-14.4605, 76.7577}, {-38.9982, 76.7577}, {-38.9982, 51.5206}, {-38.9982, 51.5206}}));
  connect(parasympatheticsystem1.signal, sinusnode1.parasympathicus) annotation(Line(points = {{4.44939, 32.9366}, {27.907, 32.9366}, {27.907, 47.9428}, {51.5206, 47.9428}, {51.5206, 26.4758}, {51.5206, 26.4758}}));
  connect(sympatheticsystem1.signal, neurotransmitteremission1.trigger) annotation(Line(points = {{-38.7097, 31.8242}, {-38.6404, 31.8242}, {-38.6404, 8.58676}, {13.5957, 8.58676}, {13.5957, 8.58676}}));
  connect(sympatheticsystem1.signal, hormoneemission1.trigger) annotation(Line(points = {{-38.7097, 31.8242}, {-38.6404, 31.8242}, {-38.6404, -3.9356}, {-5.72451, -3.9356}, {-5.72451, -3.9356}}));
  connect(baroreceptors1.signal, parasympatheticsystem1.baro) annotation(Line(points = {{-73.1924, -6.9077}, {-73.3453, -6.9077}, {-73.3453, 24.3292}, {-18.2469, 24.3292}, {-18.2469, 42.9338}, {-5.00894, 42.9338}, {-5.00894, 42.9338}}));
  connect(baroreceptors1.signal, simplelung1.baro) annotation(Line(points = {{-73.1924, -6.9077}, {-73.3453, -6.9077}, {-73.3453, 86.941}, {-24.6869, 86.941}, {-24.6869, 86.941}}));
  connect(baroreceptors1.signal, sympatheticsystem1.baro) annotation(Line(points = {{-73.1924, -6.9077}, {-73.3453, -6.9077}, {-73.3453, 41.5027}, {-49.0161, 41.5027}, {-49.0161, 41.5027}}));
  connect(hormoneamout1.con, hormoneemission1.con) annotation(Line(points = {{19.487, 2.7636}, {-5.13393, 2.7636}, {-5.13393, 5.35714}, {-5.13393, 5.35714}}));
  connect(neurotransmitteramount1.con, heart1.ccne) annotation(Line(points = {{26.6266, 18.3809}, {26.5625, 18.3809}, {26.5625, 6.02679}, {54.9107, 6.02679}, {54.9107, -0.446429}, {54.9107, -0.446429}}));
  connect(hormoneamout1.con, heart1.cvne) annotation(Line(points = {{19.487, 2.7636}, {36.8304, 2.7636}, {36.8304, 0.669643}, {37.9464, 0.669643}, {37.9464, 0}, {37.9464, 0}}));
  connect(neurotransmitteramount1.con, sinusnode1.ccne) annotation(Line(points = {{26.6266, 18.3809}, {36.8304, 18.3809}, {36.8304, 21.875}, {36.8304, 21.875}}));
  connect(neurotransmitteremission1.con, neurotransmitteramount1.con) annotation(Line(points = {{14.068, 18.5182}, {27.0089, 18.5182}, {27.0089, 18.0804}, {27.0089, 18.0804}}));
  connect(baroreceptors1.artery, bloodsystem1.vessel) annotation(Line(points = {{-73.1924, -16.9077}, {-44.1964, -16.9077}, {-44.1964, -31.4732}, {-31.6964, -31.4732}, {-31.6964, -31.4732}}));
  connect(bloodsystem1.vessel, heart1.artery) annotation(Line(points = {{-31.802, -31.3682}, {-36.7075, -31.3682}, {-36.7075, -10.0111}, {36.9299, -10.0111}, {36.9299, -10.0111}}));
  connect(sinusnode1.signal, heart1.sinusSignal) annotation(Line(points = {{46.5183, 11.6351}, {46.7186, 11.6351}, {46.7186, -0.113053}, {46.6563, -0.113053}}));
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 10, Tolerance = 0.000001));
end KotaniFullExample;
