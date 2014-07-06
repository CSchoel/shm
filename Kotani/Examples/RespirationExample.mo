within Kotani.Examples;
model RespirationExample
  Kotani.Components.Baroreceptors baroreceptors1 annotation(Placement(visible = true, transformation(origin = {-68.1127,40.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
  Kotani.Components.Basic.BloodSystem bloodSystem1 annotation(Placement(visible = true, transformation(origin = {-107.7574,1.9638}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
  Kotani.Components.Basic.LinearBloodPressure linearBloodPressure1(rate = 200) annotation(Placement(visible = true, transformation(origin = {-110.0,-30.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
  Kotani.Components.Basic.NerveSystem nerveSystem2 annotation(Placement(visible = true, transformation(origin = {-45.0,65.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
  Kotani.Components.SimpleLung simpleLung1 annotation(Placement(visible = true, transformation(origin = {0.0,72.3713}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
  Kotani.Components.Basic.RespiratorySystem respiratorySystem1 annotation(Placement(visible = true, transformation(origin = {26.9455,50.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
equation
  connect(simpleLung1.resp,respiratorySystem1.phase) annotation(Line(visible = true, origin = {1.6667,53.0278}, points = {{-1.6667,9.56059},{-1.6667,-3.0278},{15.2788,-3.0278}}));
  connect(simpleLung1.baro,nerveSystem2.fiber) annotation(Line(visible = true, origin = {-30.0,68.6857}, points = {{20,3.6856},{-2,3.6856},{-2,-3.6857},{-16,-3.6857}}));
  connect(baroreceptors1.signal,nerveSystem2.fiber) annotation(Line(visible = true, origin = {-60.7418,60.0}, points = {{-7.3709,-10.0},{-7.3709,5.0},{14.7418,5.0}}));
  connect(bloodSystem1.vessel,baroreceptors1.artery) annotation(Line(visible = true, origin = {-106.8462,20.9819}, points = {{-10.9112,-19.0181},{-13.9112,-19.0181},{-13.9112,19.0181},{38.7335,19.0181}}));
  connect(linearBloodPressure1.vessel,bloodSystem1.vessel) annotation(Line(visible = true, origin = {-115.8544,-12.0145}, points = {{5.8544,-17.9855},{5.8544,-4.9855},{-4.9029,-4.9855},{-4.9029,13.9783},{-1.903,13.9783}}));
  annotation(Diagram(coordinateSystem(extent = {{-148.5,-105},{148.5,105}}, preserveAspectRatio = false, initialScale = 0.1, grid = {5,5}), graphics));
end RespirationExample;

