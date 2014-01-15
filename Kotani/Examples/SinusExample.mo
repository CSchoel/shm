// CP: 65001
// SimulationX Version: 3.6.0.23962 x64
within Kotani.Examples;
model SinusExample
	Components.Basic.NerveSystem nerveSystem1 annotation(Placement(transformation(
		origin={-60,60},
		extent={{-10,-10},{10,10}})));
	Components.Basic.LinearNerveSignal linearNerveSignal1(topval=10) annotation(Placement(transformation(
		origin={-110,65},
		extent={{-10,-10},{10,10}})));
	Components.Basic.NerveSystem nerveSystem2 annotation(Placement(transformation(
		origin={15,50},
		extent={{-10,-10},{10,10}})));
	Components.Basic.NerveSystem nerveSystem3 annotation(Placement(transformation(
		origin={-20,-20},
		extent={{-10,-10},{10,10}})));
	Components.SinusNode sinusNode1 annotation(Placement(transformation(
		origin={-15,17.8768},
		extent={{-10,-10},{10,10}})));
	Components.Basic.LinearNerveSignal linearNerveSignal2(
		t1=3,
		t2=4,
		topval=0.1) annotation(Placement(transformation(
		origin={30,77.04040000000001},
		extent={{-10,-10},{10,10}})));
	Components.HormoneEmission hormoneEmission1;
	equation
		connect(linearNerveSignal1.nerve1,nerveSystem1.fiber) annotation(Line(
			points={{-110.2,65},{-115.2,65},{-115.2,55},{-65.8,55},{-65.8,60},{-60.8,
			60}},
			thickness=0.0625));
		connect(nerveSystem2.fiber,sinusNode1.parasympathicus) annotation(Line(
			points={{14.2,50},{9.199999999999999,50},{-10.2,50},{-10.2,28},{-10.2,23}},
			thickness=0.0625));
		connect(linearNerveSignal2.nerve1,nerveSystem2.fiber) annotation(Line(
			points={{29.8,77},{24.8,77},{9.199999999999999,77},{9.199999999999999,50},{14.2,50}},
			thickness=0.0625));
		connect(sinusNode1.phase,nerveSystem3.fiber) annotation(Line(
			points={{-14.8,8},{-14.8,3},{-25.8,3},{-25.8,-20},{-20.8,-20}},
			thickness=0.0625));
		connect(sinusNode1.ccne,hormoneEmission1.con) annotation(Line(
			points={{-24.8,18},{-29.8,18},{-29.8,55},{-43.5,55},{-43.5,50}},
			thickness=0.0625));
		connect(hormoneEmission1.trigger,nerveSystem1.fiber) annotation(
			Line(
				points={{-43.5,40},{-48.5,35},{-58.5,35},{-58.5,60},{-60.83332824707031,60}},
				thickness=0.0625),
			AutoRoute=false);
	annotation(
		sinusNode1(phase(activation(flags=2))),
		hormoneEmission1(
			trigger(activation(flags=2)),
			viewinfo[0](
				position(
					left=435,
					top=195,
					right=496,
					bottom=226),
				typename="ObjectInfo")),
		viewinfo[0](
			viewSettings(clrRaster=12632256),
			typename="ModelInfo"),
		Diagram(coordinateSystem(
			extent={{-148.5,-105},{148.5,105}},
			grid={5,5})),
		experiment(
			StopTime=1,
			StartTime=0));
end SinusExample;
