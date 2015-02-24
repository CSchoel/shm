within SHM.Kotani2005.Examples.ComponentTests;
model BaroreceptorExample "baroreceptor test"
  SHM.Kotani2005.Components.Baroreceptors baroreceptors1 "baroreceptor" annotation(Placement(transformation(origin = {-71.9822,26.8474}, extent = {{-10,-10},{10,10}})));
  SHM.Shared.Components.Compartments.BloodSystem bloodSystem1 "blood system" annotation(Placement(transformation(origin = {-15,26.8873}, extent = {{-10,-10},{10,10}})));
  SHM.Shared.Components.Test.LinearBloodPressure linearBloodPressure1 "blood pressure signal" annotation(Placement(transformation(origin = {-5,-25}, extent = {{-10,-10},{10,10}})));
equation
  connect(bloodSystem1.vessel,baroreceptors1.artery) annotation(Line(points = {{-25,26.8873},{-67.7344,26.8873},{-67.7344,29.0625},{-67.7344,29.0625}}));
  connect(linearBloodPressure1.vessel,bloodSystem1.vessel) annotation(Line(points = {{-5,-25},{-26.7188,-25},{-26.7188,26.4844},{-26.7188,26.4844}}));
  annotation(Diagram(coordinateSystem(extent = {{-148.5,-105},{148.5,105}}, grid = {5,5})), experiment(StartTime = 0, StopTime = 10, Tolerance = 0.000001));
annotation(Documentation(info="<html>Models a simple system with linear rising blood pressure and baroreceptor.</html>"));
end BaroreceptorExample;

