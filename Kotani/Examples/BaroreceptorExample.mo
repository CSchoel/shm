within Kotani.Examples;
model BaroreceptorExample
  Kotani.Components.Baroreceptors baroreceptors1 annotation(Placement(transformation(origin = {-71.9822,26.8474}, extent = {{-10,-10},{10,10}})));
  Kotani.Components.Basic.BloodSystem bloodSystem1 annotation(Placement(transformation(origin = {-15,26.8873}, extent = {{-10,-10},{10,10}})));
  Kotani.Components.Basic.LinearBloodPressure linearBloodPressure1 annotation(Placement(transformation(origin = {-5,-25}, extent = {{-10,-10},{10,10}})));
equation
  connect(bloodSystem1.vessel,baroreceptors1.artery) annotation(Line(points = {{-25,26.8873},{-67.7344,26.8873},{-67.7344,29.0625},{-67.7344,29.0625}}));
  connect(linearBloodPressure1.vessel,bloodSystem1.vessel) annotation(Line(points = {{-5,-25},{-26.7188,-25},{-26.7188,26.4844},{-26.7188,26.4844}}));
  annotation(Diagram(coordinateSystem(extent = {{-148.5,-105},{148.5,105}}, grid = {5,5})), experiment(StartTime = 0, StopTime = 10, Tolerance = 0.000001));
end BaroreceptorExample;

