within SHM.SeidelThesis.Components;
model Baroreceptors "baroreceptors measuring blood pressure"
  parameter Real p0 = 60 "minimum blood pressure needed to generate signal";
  parameter Real kb = 0.06 "sensitivity of baroreceptors to blood pressure increase";
  parameter Real sat_inflection = 120 "point of inflection for the saturation function, maximum for signal value will be at 2 * (sat_inflection - p0)";
  parameter Boolean saturated = true "if true, saturation function is applied to raw baroreceptor signal";
  parameter Boolean broadened = true "if true, boradening is applied to (saturated if saturated=true) baroreceptor signal";
  parameter Real broad_len = 0.11 "broadening length in seconds";
  parameter Real broad_res = 100 "broadening calculation steps per second";
  parameter Real broad_eta = 0.15 "broadening eta";
  parameter Real broad_sigma = 0.11 "broadening sigma";
  SHM.Shared.Connectors.BloodVessel artery "artery where blood pressure is measured" annotation(Placement(visible = true, transformation(origin = {-3.0696, 0.4341}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  SHM.Shared.Connectors.NerveOutput signal "generated nerve signal" annotation(Placement(visible = true, transformation(origin = {-1.8417, 85.0801}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {28, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SHM.Shared.Components.TanhSaturation sat(
  	x = base_signal,
  	satx = sat_signal,
  	sat_speed= 1/(sat_inflection - p0), 
  	inflection_x = sat_inflection - p0, 
  	max_val = 2 * (sat_inflection - p0)
  ) if saturated "baroreceptor saturation function";
  SHM.SeidelThesis.Components.Broaden broad(
  	x = sat_signal,
  	xbroad = broad_signal,
  	len=broad_len,
  	resolution=broad_res,
  	eta=broad_eta,
  	sigma=broad_sigma
  ) if broadened "broadening function";
protected
  Real base_signal "base signal of baroreceptors without saturation or broadening";
  Real sat_signal "base signal with saturation (if saturated=true) but without broadening";
  Real broad_signal "signal with saturation (if saturated=true) and broadening(if broadened=true)";
equation
  base_signal = artery.pressure - p0 +  kb * der(artery.pressure);
  if not saturated then
    sat_signal = base_signal;
  end if;
  if not broadened then
    broad_signal = sat_signal;
  end if;
  signal.activation = broad_signal;
  //we do not add or take anything to the flow
  artery.rate = 0;
annotation(Documentation(info="<html>
  <p>This Baroreceptor model originates from a paper of Warner from 1958.
  It includes the effects that baroreceptors only generate signals above a threshold blood pressure and that they are both sensitive to static blood pressure levels as well as to an increase or decrease in blood pressure.</p>
  <p>It was extended by Dr. Seidel in his thesis to include a saturation effect and a broadening function.</p>
</html>"), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Polygon(origin = {1.44481, -32.3079}, fillColor = {170, 0, 0}, fillPattern = FillPattern.Solid, points = {{-80.652, 29.8192}, {-92.1032, 30.4114}, {-99.4726, 27.6601}, {-99.4082, -7.49578}, {-94.0775, -7.8906}, {-56.1703, -9.86493}, {8.58782, -9.27267}, {50.8386, -19.1443}, {86.1791, -16.7751}, {94.6687, -14.6034}, {94.2739, 14.8142}, {86.3766, 15.8013}, {57.5513, 11.4579}, {23.3953, 25.673}, {-38.5988, 23.1064}, {-67.8189, 29.4243}, {-80.652, 29.8192}}, smooth = Smooth.Bezier), Ellipse(origin = {91.1747, -34.4925}, fillPattern = FillPattern.Solid, extent = {{-6.02, 16.58}, {3.84823, -12.8288}}, endAngle = 360), Polygon(origin = {-9.91, 18.03}, fillColor = {170, 255, 255}, fillPattern = FillPattern.Solid, points = {{25.158, 45.3143}, {32.1961, 54.4052}, {33.3692, 54.9917}, {38.0612, 51.1794}, {36.595, 50.5929}, {21.9322, 35.9301}, {14.0143, 30.6515}, {4.92341, 19.2146}, {-1.23494, 2.79231}, {-6.80679, -9.81766}, {-10.0326, -21.2546}, {-10.0326, -26.24}, {-5.92703, -29.1725}, {-0.0619239, -28.586}, {5.80318, -26.24}, {11.9615, -29.759}, {18.9997, -30.3455}, {20.8336, -30.5343}, {21.579, -31.8518}, {18.4131, -32.6916}, {12.2548, -31.2253}, {8.44247, -30.3455}, {5.50992, -28.586}, {-2.11471, -30.6388}, {-6.51354, -30.932}, {-10.2414, -29.7491}, {-7.97981, -32.9848}, {-1.23494, -35.3309}, {3.45714, -33.2781}, {8.14922, -34.7443}, {10.4953, -39.1432}, {18.9997, -40.0229}, {22.2255, -35.9174}, {24.8448, -34.2223}, {26.9031, -33.447}, {30.3222, -33.6358}, {31.6441, -34.8588}, {29.4624, -35.4453}, {26.331, -35.3309}, {22.812, -37.6769}, {20.4659, -40.3162}, {25.158, -44.1285}, {28.9703, -44.1285}, {30.8143, -45.898}, {30.8488, -47.4487}, {28.2894, -45.9824}, {25.7445, -45.0083}, {23.1052, -45.0083}, {19.8794, -41.4892}, {9.90875, -40.9027}, {7.26945, -37.9702}, {6.09643, -35.3309}, {0.817842, -36.5039}, {3.75039, -42.369}, {9.02899, -43.2487}, {10.6396, -45.6848}, {11.9615, -51.1666}, {17.2401, -52.0464}, {20.7592, -52.0464}, {22.3099, -52.5385}, {23.0897, -53.6671}, {19.765, -53.8259}, {16.9469, -53.5127}, {11.375, -52.6329}, {9.59551, -50.118}, {9.02899, -47.0611}, {6.9762, -44.4218}, {4.63016, -43.8353}, {4.3369, -48.5273}, {1.78203, -52.5685}, {0.146905, -54.278}, {-1.42378, -54.9835}, {-0.499566, -52.2996}, {0.912262, -50.779}, {3.16388, -44.715}, {-0.355179, -37.9702}, {-4.75401, -36.2106}, {-6.51354, -41.196}, {-10.0326, -42.0757}, {-12.3786, -47.0611}, {-10.3259, -48.5273}, {-7.16448, -51.2211}, {-4.03862, -54.4314}, {-7.3933, -53.8059}, {-8.10422, -52.3896}, {-10.3259, -50.8734}, {-14.7247, -47.3543}, {-18.8303, -49.7004}, {-22.1804, -51.3211}, {-24.8642, -53.5771}, {-25.9328, -52.8462}, {-23.6967, -50.3913}, {-20.2965, -47.6476}, {-14.1382, -44.4218}, {-10.9124, -40.0229}, {-8.27307, -38.5567}, {-8.56632, -35.0376}, {-15.3112, -36.2106}, {-18.8303, -39.4364}, {-24.1088, -39.7297}, {-30.2672, -40.3162}, {-31.7335, -45.0083}, {-34.666, -48.244}, {-36.8776, -49.556}, {-37.0121, -47.9008}, {-36.0034, -46.0669}, {-35.2525, -45.0083}, {-32.32, -39.1432}, {-28.5077, -36.7971}, {-23.8156, -37.0904}, {-21.4695, -36.2106}, {-15.6044, -34.1578}, {-12.8607, -31.6129}, {-13.9193, -29.3414}, {-19.1235, -31.8118}, {-24.6954, -33.5713}, {-30.5605, -32.6916}, {-34.3573, -30.8131}, {-32.3844, -29.729}, {-27.9267, -31.2397}, {-21.8227, -30.0622}, {-15.3112, -27.1197}, {-14.1382, -25.0669}, {-12.3786, -14.2165}, {-8.27307, -3.36605}, {-0.941689, 18.3348}, {6.38969, 28.3055}, {17.5334, 39.1559}, {25.158, 45.3143}}, smooth = Smooth.Bezier)}));
end Baroreceptors;