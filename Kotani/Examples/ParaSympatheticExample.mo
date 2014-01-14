within Kotani.Examples;
model ParaSympatheticExample
  Kotani.Components.Basic.LinearBloodPressure linearBloodPressure annotation(Placement(transformation(extent = {{-78,-18},{-58,2}})));
  Kotani.Components.Basic.BloodSystem bloodSystem annotation(Placement(transformation(extent = {{-78,14},{-58,34}})));
  Kotani.Components.Baroreceptors baroreceptors annotation(Placement(transformation(extent = {{-70,54},{-50,74}})));
  Kotani.Components.SimpleLung simpleLung annotation(Placement(transformation(extent = {{-10,66},{10,86}})));
  Kotani.Components.Basic.RespiratorySystem respiratorySystem annotation(Placement(transformation(extent = {{30,44},{50,64}})));
  Kotani.Components.Basic.NerveSystem nerveSystem annotation(Placement(transformation(extent = {{-44,64},{-24,84}})));
  Kotani.Components.Basic.NerveSystem nerveSystem1 annotation(Placement(transformation(extent = {{6,-26},{26,-6}})));
  Kotani.Components.ParasympatheticSystem parasympatheticSystem1 annotation(Placement(visible = true, transformation(origin = {3.3073,20.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
equation
  connect(parasympatheticSystem1.resp,respiratorySystem.phase) annotation(Line(visible = true, origin = {12.2049,46.0}, points = {{-8.8976,-16.0},{-8.8976,8.0},{17.7951,8.0}}));
  connect(parasympatheticSystem1.signal,nerveSystem1.fiber) annotation(Line(visible = true, origin = {9.1536,-3.0}, points = {{-5.8463,13.0},{-5.8463,0.0},{5.8464,0.0},{5.8464,-13.0}}));
  connect(nerveSystem.fiber,parasympatheticSystem1.baro) annotation(Line(visible = true, origin = {-25.5642,38.0}, points = {{-9.4358,36.0},{-9.4358,-18.0},{18.8715,-18.0}}));
  connect(bloodSystem.vessel,linearBloodPressure.vessel) annotation(Line(points = {{-78,24},{-78,-8},{-68,-8}}, color = {0,0,0}, smooth = Smooth.None));
  connect(bloodSystem.vessel,baroreceptors.artery) annotation(Line(points = {{-78,24},{-84,24},{-84,64},{-60,64}}, color = {0,0,0}, smooth = Smooth.None));
  connect(simpleLung.resp,respiratorySystem.phase) annotation(Line(points = {{0,66.2171},{16,66.2171},{16,54},{30,54}}, color = {0,0,0}, smooth = Smooth.None));
  connect(nerveSystem.fiber,baroreceptors.signal) annotation(Line(points = {{-35,74},{-60,74}}, color = {0,0,0}, smooth = Smooth.None));
  connect(nerveSystem.fiber,simpleLung.baro) annotation(Line(points = {{-35,74},{-22,74},{-22,76},{-10,76}}, color = {0,0,0}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
end ParaSympatheticExample;

