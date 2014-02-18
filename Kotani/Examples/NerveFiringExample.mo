within Kotani.Examples;
model NerveFiringExample
  Components.Basic.FiringNerve firingNerve1 annotation(Placement(transformation(extent = {{-48,42},{-27,52}})));
  Components.Basic.NerveSystem nerveSystem1 annotation(Placement(transformation(extent = {{-90,40},{-70,60}})));
  Kotani.Components.Basic.FiringNerveReceiver firingnervereceiver1 annotation(Placement(visible = true, transformation(origin = {-72.6297,12.5224}, extent = {{-10,-10},{10,10}}, rotation = 0)));
equation
  connect(nerveSystem1.fiber,firingnervereceiver1.nerve1) annotation(Line(points = {{-81,50},{-72.9875,50},{-72.9875,22.5403},{-72.9875,22.5403}}));
  connect(nerveSystem1.fiber,firingNerve1.nerve1) annotation(Line(points = {{-81,50},{-86,50},{-86,40},{-53,40},{-53,47},{-48,47}}, thickness = 0.0625));
  annotation(firingNerve1(nerve1(activation(flags = 2), rate(flags = 2))), nerveSystem1(fiber(activation(flags = 2))), experiment(StopTime = 10, StartTime = 0));
end NerveFiringExample;

