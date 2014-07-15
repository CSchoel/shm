within Kotani.Examples;

model KotaniFullExample 
  "Full Kotani model with all components"
  //parameter Real baro_activity = 2 "Initial baroreceptor activity";
  parameter Real conc_cNe = 0.25 "Initial cardiac concentration of Norepinephrine";
  parameter Real conc_vNe = 0.25 "Initial vascular concentration of Norepinephrine";
  parameter Real hypertension = 0 "initial hypertensive factor";
  parameter Real last_beat_p = 250 "Initial value for diastolic blood pressure";
  parameter Real pacemaker = 0 "Initial pacemaker phase";
  //parameter Real para_activity = 2 "Initial parasympathetic activity";
  parameter Real pressure = 500 "Initial blood pressure";
  //parameter Real respiratory_influence = 0.5 "initial respiratory influence";
  parameter Real respiratory_phase = 0.5 "initial respiratory phase";
  //parameter Real symp_activity = 0.2 "initial sympathetic activity";
  //parameter Real windkessel_relax = 0 "initial windkessel relaxation";
  Kotani.Components.SimpleLung lung(initialR=respiratory_phase) "the Lung" annotation(Placement(visible = true, transformation(origin = {-14.4605, 86.5406}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Kotani.Components.Heart heart(initialS=hypertension,initialPlast=last_beat_p) "the heart" annotation(Placement(visible = true, transformation(origin = {46.941, -9.78865}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Kotani.Components.SinusNode sinus(initialPhase=pacemaker) "the sinus node" annotation(Placement(visible = true, transformation(origin = {46.4961, 21.802}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Kotani.Components.ParasympatheticSystem para "parasympathetic system" annotation(Placement(visible = true, transformation(origin = {4.44939, 42.9366}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Kotani.Components.SympatheticSystem symp "sympathetic system" annotation(Placement(visible = true, transformation(origin = {-38.7097, 41.8242}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Kotani.Components.Baroreceptors baro "baroreceptor" annotation(Placement(visible = true, transformation(origin = {-73.1924, -16.9077}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Kotani.Components.Basic.BloodSystem blood(initialPressure=pressure) "main blood system" annotation(Placement(visible = true, transformation(origin = {-21.802, -31.3682}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Kotani.Components.NeurotransmitterEmission cNeEmit "emission of cardiac Norepinephrine" annotation(Placement(visible = true, transformation(origin = {14.238, 13.3482}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Kotani.Components.HormoneEmission vNeEmit "emission of vascular Norepinephrine" annotation(Placement(visible = true, transformation(origin = {-5.33924, 0.667451}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Kotani.Components.Basic.NeurotransmitterAmount cNeAmount(initialConcentration=conc_cNe) "amount of cardiac Norepinephrine" annotation(Placement(visible = true, transformation(origin = {26.5848, 18.2813}, extent = {{-2.87946, -2.87946}, {2.87946, 2.87946}}, rotation = 0)));
  Kotani.Components.Basic.HormoneAmout vNeAmount(initialConcentration=conc_vNe) "amount of vascular Norepinephrine" annotation(Placement(visible = true, transformation(origin = {19.442, 2.65625}, extent = {{-3.10268, -3.10268}, {3.10268, 3.10268}}, rotation = 0)));
equation
  connect(lung.resp, para.resp) annotation(Line(points = {{-14.4605, 76.7577}, {5.36673, 76.7577}, {5.36673, 52.9517}, {5.36673, 52.9517}}));
  connect(lung.resp, symp.resp) annotation(Line(points = {{-14.4605, 76.7577}, {-38.9982, 76.7577}, {-38.9982, 51.5206}, {-38.9982, 51.5206}}));
  connect(para.signal, sinus.parasympathicus) annotation(Line(points = {{4.44939, 32.9366}, {27.907, 32.9366}, {27.907, 47.9428}, {51.5206, 47.9428}, {51.5206, 26.4758}, {51.5206, 26.4758}}));
  connect(symp.signal, cNeEmit.trigger) annotation(Line(points = {{-38.7097, 31.8242}, {-38.6404, 31.8242}, {-38.6404, 8.58676}, {13.5957, 8.58676}, {13.5957, 8.58676}}));
  connect(symp.signal, vNeEmit.trigger) annotation(Line(points = {{-38.7097, 31.8242}, {-38.6404, 31.8242}, {-38.6404, -3.9356}, {-5.72451, -3.9356}, {-5.72451, -3.9356}}));
  connect(baro.signal, para.baro) annotation(Line(points = {{-73.1924, -6.9077}, {-73.3453, -6.9077}, {-73.3453, 24.3292}, {-18.2469, 24.3292}, {-18.2469, 42.9338}, {-5.00894, 42.9338}, {-5.00894, 42.9338}}));
  connect(baro.signal, lung.baro) annotation(Line(points = {{-73.1924, -6.9077}, {-73.3453, -6.9077}, {-73.3453, 86.941}, {-24.6869, 86.941}, {-24.6869, 86.941}}));
  connect(baro.signal, symp.baro) annotation(Line(points = {{-73.1924, -6.9077}, {-73.3453, -6.9077}, {-73.3453, 41.5027}, {-49.0161, 41.5027}, {-49.0161, 41.5027}}));
  connect(vNeAmount.con, vNeEmit.con) annotation(Line(points = {{19.487, 2.7636}, {-5.13393, 2.7636}, {-5.13393, 5.35714}, {-5.13393, 5.35714}}));
  connect(cNeAmount.con, heart.ccne) annotation(Line(points = {{26.6266, 18.3809}, {26.5625, 18.3809}, {26.5625, 6.02679}, {54.9107, 6.02679}, {54.9107, -0.446429}, {54.9107, -0.446429}}));
  connect(vNeAmount.con, heart.cvne) annotation(Line(points = {{19.487, 2.7636}, {36.8304, 2.7636}, {36.8304, 0.669643}, {37.9464, 0.669643}, {37.9464, 0}, {37.9464, 0}}));
  connect(cNeAmount.con, sinus.ccne) annotation(Line(points = {{26.6266, 18.3809}, {36.8304, 18.3809}, {36.8304, 21.875}, {36.8304, 21.875}}));
  connect(cNeEmit.con, cNeAmount.con) annotation(Line(points = {{14.068, 18.5182}, {27.0089, 18.5182}, {27.0089, 18.0804}, {27.0089, 18.0804}}));
  connect(baro.artery, blood.vessel) annotation(Line(points = {{-73.1924, -16.9077}, {-44.1964, -16.9077}, {-44.1964, -31.4732}, {-31.6964, -31.4732}, {-31.6964, -31.4732}}));
  connect(blood.vessel, heart.artery) annotation(Line(points = {{-31.802, -31.3682}, {-36.7075, -31.3682}, {-36.7075, -10.0111}, {36.9299, -10.0111}, {36.9299, -10.0111}}));
  connect(sinus.signal, heart.sinusSignal) annotation(Line(points = {{46.5183, 11.6351}, {46.7186, 11.6351}, {46.7186, -0.113053}, {46.6563, -0.113053}}));
  annotation(Documentation(info="Full Kotani model with standard parameters"),Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 10, Tolerance = 0.000001));
end KotaniFullExample;
