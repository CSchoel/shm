within Kotani.Examples;
model ComplexHeartExample
  Components.Basic.NerveSystem nerveSystem1 annotation(Placement(visible = true, transformation(origin = {50.3488,9.63327}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Components.Basic.LinearNerveSignal linearNerveSignal1 annotation(Placement(visible = true, transformation(origin = {51.5116,-15.0089}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Components.NeurotransmitterEmission neurotransmitterEmission1 annotation(Placement(visible = true, transformation(origin = {25.3041,66.4311}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Components.HormoneEmission hormoneEmission1 annotation(Placement(visible = true, transformation(origin = {70.7424,64.6422}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Kotani.Components.Basic.DiracSignal diracsignal1 annotation(Placement(visible = true, transformation(origin = {-11.0906,65.8041}, extent = {{-10.17,-5.17},{10.17,5.17}}, rotation = 0)));
  Kotani.Components.Heart heart1 annotation(Placement(visible = true, transformation(origin = {-19.6303,-15.8965}, extent = {{33.2717,-33.2717},{-33.2717,33.2717}}, rotation = 0)));
  Components.Basic.BloodSystem bloodSystem1 annotation(Placement(visible = true, transformation(origin = {36.2343,-48.4531}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Kotani.Components.Baroreceptors baroreceptors1 annotation(Placement(visible = true, transformation(origin = {-54.6875,-62.2768}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Kotani.Components.Basic.NerveSystem nervesystem1 annotation(Placement(visible = true, transformation(origin = {-77.2321,-29.4643}, extent = {{-10,-10},{10,10}}, rotation = 0)));
initial equation
  bloodSystem1.vessel.pressure = 50;
equation
  connect(baroreceptors1.signal,nervesystem1.fiber) annotation(Line(points = {{-54.6875,-52.2768},{-77.6786,-52.2768},{-77.6786,-30.3571},{-77.6786,-30.3571}}));
  connect(baroreceptors1.artery,bloodSystem1.vessel) annotation(Line(points = {{-54.6875,-62.2768},{26.1161,-62.2768},{26.1161,-48.2143},{26.1161,-48.2143}}));
  connect(heart1.ccne,hormoneEmission1.con) annotation(Line(points = {{-46.78,17.3752},{-47.6895,17.3752},{-47.6895,88.7246},{70.9797,88.7246},{70.9797,69.1312},{70.9797,69.1312}}));
  connect(heart1.cvne,neurotransmitterEmission1.con) annotation(Line(points = {{13.1091,17.3752},{12.5693,52.4954},{24.7689,71.6011},{25.1341,71.6011}}));
  connect(bloodSystem1.vessel,heart1.artery) annotation(Line(points = {{26.2343,-48.4531},{14.7874,-48.4531},{14.7874,-15.5268},{14.7874,-15.5268}}));
  connect(heart1.sinusSignal,diracsignal1.signal) annotation(Line(points = {{-18.683,16.2959},{-1.47874,16.2959},{-1.47874,62.1072},{-1.36218,62.1072},{-1.36218,61.8668}}));
  connect(linearNerveSignal1.nerve1,nerveSystem1.fiber) annotation(Line(points = {{51.5116,-15.0089},{49.7317,-15.0089},{49.7317,10.0179},{49.7317,10.0179}}));
  connect(nerveSystem1.fiber,neurotransmitterEmission1.trigger) annotation(Line(points = {{49.3488,9.63327},{25.0447,9.63327},{25.0447,61.5385},{25.0447,61.5385}}));
  connect(nerveSystem1.fiber,hormoneEmission1.trigger) annotation(Line(points = {{49.3488,9.63327},{70.8408,9.63327},{70.8408,59.3918},{70.8408,59.3918}}));
  connect(linearNerveSignal1.nerve1,nerveSystem1.fiber) annotation(Line(points = {{5,-10},{10,-10},{55,-10},{55,15},{54,15}}, thickness = 0.0625), AutoRoute = false);
  annotation(experiment(StartTime = 0, StopTime = 10, Tolerance = 0.000001));
end ComplexHeartExample;

