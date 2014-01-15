// CP: 65001
// SimulationX Version: 3.6.0.23962 x64
within Kotani.Examples;
model SubstanceExample "example for substances"
	Components.Basic.NerveSystem nerveSystem1 annotation(Placement(transformation(extent={{-50,65},{-30,85}})));
	Components.Basic.LinearNerveSignal linearNerveSignal1 annotation(Placement(transformation(extent={{5,70},{25,90}})));
	Components.HormoneEmission hormoneEmission1 annotation(Placement(transformation(extent={{-84,31},{-64,51}})));
	equation
		connect(hormoneEmission1.trigger,nerveSystem1.fiber) annotation(Line(
			points={{-74.3,36.3},{-74.3,31.3},{-60.3,31.3},{-60.3,75},{-46,75},{-41,
			75}},
			thickness=0.0625));
		connect(nerveSystem1.fiber,linearNerveSignal1.nerve1) annotation(
			Line(
				points={{-41,75},{-10,75},{-10,85},{10,85},{10,80},{15,
				80}},
				thickness=0.0625),
			AutoRoute=false);
	annotation(
		hormoneEmission1(
			trigger(activation(flags=2)),
			con(concentration(flags=2))),
		viewinfo[0](
			viewSettings(clrRaster=12632256),
			typename="ModelInfo"),
		experiment(
			StopTime=10,
			StartTime=0));
end SubstanceExample;
