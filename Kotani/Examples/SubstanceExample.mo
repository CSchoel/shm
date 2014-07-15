within Kotani.Examples;
model SubstanceExample "example for substances"
  Components.Basic.LinearNerveSignal linearNerveSignal1 annotation(Placement(transformation(extent = {{5,70},{25,90}})));
  Components.HormoneEmission hormoneEmission1 annotation(Placement(transformation(extent = {{-84,31},{-64,51}})));
  Kotani.Components.Basic.HormoneAmout hormoneamout1 annotation(Placement(visible = true, transformation(origin = {-80.5804,80.5804}, extent = {{-10,-10},{10,10}}, rotation = 0)));
equation
  connect(hormoneEmission1.con,hormoneamout1.con) annotation(Line(points = {{-74.17,46.17},{-80.1339,46.17},{-80.1339,79.2411},{-80.1339,79.2411}}));
  connect(linearNerveSignal1.nerve1,hormoneEmission1.trigger) annotation(Line(points = {{-74.3,36.3},{-74.3,31.3},{-60.3,31.3},{-60.3,75},{-46,75},{-41,75}}, thickness = 0.0625));
  annotation(hormoneEmission1(trigger(activation(flags = 2)), con(concentration(flags = 2))), experiment(StartTime = 0, StopTime = 10, Tolerance = 0.000001));
end SubstanceExample;

