within Kotani.Examples;
model ParaSympatheticExample
  Kotani.Components.Basic.LinearBloodPressure linearBloodPressure annotation(Placement(transformation(extent = {{-78,-18},{-58,2}})));
  Kotani.Components.Basic.BloodSystem bloodSystem annotation(Placement(transformation(extent = {{-78,14},{-58,34}})));
  Kotani.Components.Baroreceptors baroreceptors annotation(Placement(transformation(extent = {{-70,54},{-50,74}})));
  Kotani.Components.SimpleLung simpleLung annotation(Placement(transformation(extent = {{-10,66},{10,86}})));
  Kotani.Components.ParasympatheticSystem parasympatheticSystem1 annotation(Placement(visible = true, transformation(origin = {3.3073,20.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
equation
  connect(bloodSystem.vessel,linearBloodPressure.vessel) annotation(Line(points = {{-78,24},{-78,-8},{-68,-8}}, color = {0,0,0}, smooth = Smooth.None));
  connect(bloodSystem.vessel,baroreceptors.artery) annotation(Line(points = {{-78,24},{-84,24},{-84,64},{-60,64}}, color = {0,0,0}, smooth = Smooth.None));
  connect(simpleLung.resp,parasympatheticSystem1.resp) annotation(Line(points = {{0,66.2171},{16,66.2171},{16,54},{30,54}}, color = {0,0,0}, smooth = Smooth.None));
  connect(baroreceptors.signal,parasympatheticSystem1.baro) annotation(Line(points = {{-35,74},{-60,74}}, color = {0,0,0}, smooth = Smooth.None));
  connect(baroreceptors.signal,simpleLung.baro) annotation(Line(points = {{-35,74},{-22,74},{-22,76},{-10,76}}, color = {0,0,0}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
end ParaSympatheticExample;

