within SHM.Kotani2005.Examples.ComponentTests;
model SympatheticExample
  SHM.Shared.Components.Test.LinearBloodPressure linearBloodPressure "blood pressure signal" annotation(Placement(transformation(extent = {{-78,-18},{-58,2}})));
  SHM.Shared.Components.Compartments.BloodSystem bloodSystem "blood system" annotation(Placement(transformation(extent = {{-78,14},{-58,34}})));
  SHM.Kotani2005.Components.Baroreceptors baroreceptors "baroreceptors" annotation(Placement(transformation(extent = {{-70,54},{-50,74}})));
  SHM.Kotani2005.Components.SimpleLung simpleLung "lung model" annotation(Placement(transformation(extent = {{-10,66},{10,86}})));
  SHM.Kotani2005.Components.SympatheticSystem sympatheticSystem "sympathetic system" annotation(Placement(transformation(extent = {{0,8},{20,28}})));
equation
  connect(bloodSystem.vessel,linearBloodPressure.vessel) annotation(Line(points = {{-78,24},{-78,-8},{-68,-8}}, color = {0,0,0}, smooth = Smooth.None));
  connect(bloodSystem.vessel,baroreceptors.artery) annotation(Line(points = {{-78,24},{-84,24},{-84,64},{-60,64}}, color = {0,0,0}, smooth = Smooth.None));
  connect(simpleLung.resp,sympatheticSystem.resp) annotation(Line(points = {{0,66.2171},{6,66.2171},{6,28},{10,28}}, color = {0,0,0}, smooth = Smooth.None));
  connect(baroreceptors.signal,simpleLung.baro) annotation(Line(points = {{-35,74},{-22,74},{-22,76},{-10,76}}, color = {0,0,0}, smooth = Smooth.None));
  connect(baroreceptors.signal,sympatheticSystem.baro) annotation(Line(points = {{-35,74},{-18,74},{-18,18},{0,18}}, color = {0,0,0}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics), experiment(StartTime = 0, StopTime = 10, Tolerance = 0.000001));
annotation(Documentation(info="<html>
  <p>Models simple test system with baroreceptors, lung and sympathetic system.</p>
</html>"));
end SympatheticExample;

