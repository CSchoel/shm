within Kotani.Examples;
model BaroreceptorExample
  Kotani.Components.Baroreceptors baroreceptors1 annotation(Placement(visible = true, transformation(origin = {-71.9822,26.8474}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
  Kotani.Components.Basic.BloodSystem bloodSystem1 annotation(Placement(visible = true, transformation(origin = {-15.0,26.8873}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
  Kotani.Components.Basic.NerveSystem nerveSystem1 annotation(Placement(visible = true, transformation(origin = {-80.0,75.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
  Kotani.Components.Basic.LinearBloodPressure linearBloodPressure1 annotation(Placement(visible = true, transformation(origin = {-5.0,-25.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
equation
  connect(linearBloodPressure1.vessel,bloodSystem1.vessel) annotation(Line(visible = true, origin = {-18.2,0.9549}, points = {{13.2,-25.9549},{13.2,-12.9549},{-9.8,-12.9549},{-9.8,25.9324},{-6.8,25.9324}}));
  connect(baroreceptors1.signal,nerveSystem1.fiber) annotation(Line(visible = true, origin = {-76.4911,58.9618}, points = {{4.5089,-22.1144},{4.5089,3.0382},{-4.5089,3.0382},{-4.5089,16.0382}}));
  connect(baroreceptors1.artery,bloodSystem1.vessel) annotation(Line(visible = true, origin = {-38.2456,26.8673}, points = {{-33.7366,-0.0199},{10.2455,-0.0199},{10.2455,0.0199},{13.2455,0.0199}}));
  annotation(Diagram(coordinateSystem(extent = {{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5,5})));
end BaroreceptorExample;

