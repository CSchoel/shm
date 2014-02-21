within Kotani.Examples;
model SympatheticExample
  Components.Basic.LinearBloodPressure linearBloodPressure annotation(Placement(transformation(extent = {{-78,-18},{-58,2}})));
  Components.Basic.BloodSystem bloodSystem annotation(Placement(transformation(extent = {{-78,14},{-58,34}})));
  Components.Baroreceptors baroreceptors annotation(Placement(transformation(extent = {{-70,54},{-50,74}})));
  Components.SimpleLung simpleLung annotation(Placement(transformation(extent = {{-10,66},{10,86}})));
  Components.Basic.RespiratorySystem respiratorySystem annotation(Placement(transformation(extent = {{30,44},{50,64}})));
  Components.SympatheticSystem sympatheticSystem annotation(Placement(transformation(extent = {{0,8},{20,28}})));
  Components.Basic.NerveSystem nerveSystem annotation(Placement(transformation(extent = {{-44,64},{-24,84}})));
  Components.Basic.NerveSystem nerveSystem1 annotation(Placement(transformation(extent = {{6,-26},{26,-6}})));
equation
  connect(bloodSystem.vessel,linearBloodPressure.vessel) annotation(Line(points = {{-78,24},{-78,-8},{-68,-8}}, color = {0,0,0}, smooth = Smooth.None));
  connect(bloodSystem.vessel,baroreceptors.artery) annotation(Line(points = {{-78,24},{-84,24},{-84,64},{-60,64}}, color = {0,0,0}, smooth = Smooth.None));
  connect(simpleLung.resp,respiratorySystem.phase) annotation(Line(points = {{0,66.2171},{16,66.2171},{16,54},{30,54}}, color = {0,0,0}, smooth = Smooth.None));
  connect(simpleLung.resp,sympatheticSystem.resp) annotation(Line(points = {{0,66.2171},{6,66.2171},{6,28},{10,28}}, color = {0,0,0}, smooth = Smooth.None));
  connect(nerveSystem.fiber,baroreceptors.signal) annotation(Line(points = {{-35,74},{-60,74}}, color = {0,0,0}, smooth = Smooth.None));
  connect(nerveSystem.fiber,simpleLung.baro) annotation(Line(points = {{-35,74},{-22,74},{-22,76},{-10,76}}, color = {0,0,0}, smooth = Smooth.None));
  connect(nerveSystem.fiber,sympatheticSystem.baro) annotation(Line(points = {{-35,74},{-18,74},{-18,18},{0,18}}, color = {0,0,0}, smooth = Smooth.None));
  connect(nerveSystem1.fiber,sympatheticSystem.signal) annotation(Line(points = {{15,-16},{12,-16},{12,8},{10,8}}, color = {0,0,0}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics), experiment(StartTime = 0, StopTime = 10, Tolerance = 0.000001));
end SympatheticExample;

