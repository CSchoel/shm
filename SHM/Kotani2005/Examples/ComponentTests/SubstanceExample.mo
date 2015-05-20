within SHM.Kotani2005.Examples.ComponentTests;
model SubstanceExample "example for substance emissions"
  SHM.Shared.Components.Test.LinearNerveSignal linearNerveSignal1 "emission trigger signal" annotation(Placement(transformation(extent = {{5,70},{25,90}})));
  SHM.Kotani2005.Components.HormoneRelease HormoneRelease1 "hormone emission" annotation(Placement(transformation(extent = {{-84,31},{-64,51}})));
  SHM.Shared.Components.Compartments.HormoneAmount HormoneAmount1 "hormone concentration" annotation(Placement(visible = true, transformation(origin = {-80.5804,80.5804}, extent = {{-10,-10},{10,10}}, rotation = 0)));
equation
  connect(HormoneRelease1.con,HormoneAmount1.con) annotation(Line(points = {{-74.17,46.17},{-80.1339,46.17},{-80.1339,79.2411},{-80.1339,79.2411}}));
  connect(linearNerveSignal1.nerve1,HormoneRelease1.trigger) annotation(Line(points = {{-74.3,36.3},{-74.3,31.3},{-60.3,31.3},{-60.3,75},{-46,75},{-41,75}}, thickness = 0.0625));
  annotation(HormoneRelease1(trigger(activation(flags = 2)), con(concentration(flags = 2))), experiment(StartTime = 0, StopTime = 10, Tolerance = 0.000001));
annotation(Documentation(info="<html>
  <p>Models a small test system with a hormone emission and a synthetic trigger signal.</p>
</html>"));
end SubstanceExample;
