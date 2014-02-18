within Kotani.Components;
model Gedoens "Gedönsmodell das Gedöns simuliert"
  parameter Real gedoensigkeit = 10;
  Basic.NerveSystem nerveSystem1 annotation(Placement(transformation(extent = {{-85,50},{-65,70}})));
  Basic.LinearNerveSignal linearNerveSignal1 annotation(Placement(transformation(extent = {{20,65},{40,85}})));
equation
  connect(linearNerveSignal1.nerve1,nerveSystem1.fiber) annotation(Line(points = {{30,75},{25,75},{-81,75},{-81,60},{-76,60}}, thickness = 0.0625));
  annotation(experiment(StopTime = 1, StartTime = 0));
end Gedoens;

