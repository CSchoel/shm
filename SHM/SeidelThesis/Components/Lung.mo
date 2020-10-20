within SHM.SeidelThesis.Components;
model Lung "Lung model with simple sinus signal"
  parameter Real T_r0 = 4 "respiratory base period";
  parameter Real r_start = 0 "respiratory phase shift in seconds";
  parameter Real sigma_T_r = 0.2 "sigma for gaussian noise for respiratory phase fluctuations";
  parameter Real r_noise_last1 = 0.5 "ratio of last noise value that is kept";
  parameter Real r_noise_last2 = 0.25 "ratio of second last noise value that is kept";
  parameter Real initial_noise = 0 "initial value for respiratory period noise";
  parameter Real initial_noise_last1 = 0 "initial value for respiratory period noise during last beat";
  parameter Real initial_noise_last2 = 0 "initial value for respiratory period noise during second last beat";
  SHM.Shared.Connectors.NerveOutput signal "generated nerve signal"  annotation(Placement(visible = true, transformation(origin = {0,-80}, extent = {{-14.85,-10.5},{14.85,10.5}}, rotation = 0), iconTransformation(origin = {0, -80}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
  SHM.Shared.Connectors.RespirationOutput resp "mechanical respiratory phase"  annotation(Placement(visible = true, transformation(origin = {100,-20}, extent = {{-14.85,-10.5},{14.85,10.5}}, rotation = 0), iconTransformation(origin = {100, -20}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
  Real phi_r(start = 0, fixed=true) "internal respiratory phase";
  Real T_r(start=T_r0, fixed=true) "respiratory period with noise";
  SHM.Shared.Components.Noise.AutoregressiveGaussianDeg2 T_r_fluct(
    trigger=phase_end, sigma=sigma_T_r, r_last1=r_noise_last1,y
    r_last2=r_noise_last2, stimPeriod=0.1, noise.start=initial_noise,
    noise_last1.start=initial_noise_last1, noise_last2.start=initial_noise_last2
  );
protected
  Boolean phase_end = phi_r > 1;
equation
  der(phi_r) = 1/T_r;
  when phase_end then
    T_r = T_r0 + T_r_fluct.noise;
    reinit(phi_r,0);
  end when;
  resp.phase = - sin(2*Modelica.Constants.pi*phi_r); // FIXME: shouldn't r_start also affect this?
  signal.activation = 0.5 * (1 - sin(2*Modelica.Constants.pi*(phi_r + r_start/T_r)));
annotation(Documentation(info="<html>
  <p>Models the activity of the respiratory neurons as a simple sinus function with values between 0 and 1.</p>
</html>"), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Polygon(origin = {-47.48, -46.31}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, points = {{34.2535, 38.6113}, {33.6612, 22.6192}, {33.4637, 0.704127}, {33.8586, -15.8803}, {31.6868, -28.1211}, {23.7895, -34.2416}, {10.7589, -38.3877}, {-10.5639, -37.4005}, {-31.097, -35.2287}, {-34.2559, -33.4518}, {-32.8739, -16.0777}, {34.2535, 38.6113}}, smooth = Smooth.Bezier), Polygon(origin = {48.37, -46.19}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, points = {{-34.3546, 41.8457}, {-34.552, 27.433}, {-32.9725, 8.8743}, {-33.3674, -0.997371}, {-36.3289, -11.2639}, {-36.9212, -19.1612}, {-34.552, -24.6894}, {-27.247, -32.1918}, {-11.4523, -37.72}, {13.0295, -41.2738}, {29.6139, -41.6686}, {35.9317, -39.2994}, {36.9189, -37.72}, {35.9317, -6.72294}, {-34.3546, 41.8457}}, smooth = Smooth.Bezier), Polygon(origin = {-3.56, 54.26}, fillColor = {170, 255, 255}, fillPattern = FillPattern.Solid, points = {{-18.3568, -26.6199}, {-12.6312, -21.2892}, {-9.66972, -16.3533}, {-7.49795, -9.24575}, {-5.52362, 17.0129}, {-4.14159, 35.5716}, {-2.56212, 37.1511}, {2.37372, 38.5331}, {5.33522, 37.7434}, {7.30955, 36.5588}, {7.50698, 34.387}, {7.11212, 17.6052}, {7.11212, 3.19256}, {6.51982, -7.66628}, {7.50698, -15.3662}, {12.6403, -25.0404}, {18.3658, -30.766}, {14.2197, -38.6633}, {7.90185, -34.5172}, {2.57115, -29.9762}, {0.201948, -28.5942}, {-3.35185, -29.3839}, {-9.66972, -33.9249}, {-13.8158, -35.7018}, {-18.3568, -26.6199}}, smooth = Smooth.Bezier), Polygon(origin = {47.19, -1.42}, fillColor = {0, 85, 255}, fillPattern = FillPattern.Solid, points = {{-25.8642, 64.0057}, {-23.8899, 57.8852}, {-23.2976, 54.134}, {-34.4131, 42.7915}, {-35.7359, 40.5111}, {-35.9333, 60.4519}, {-33.3667, 71.3107}, {-26.8514, 80.1952}, {-18.3618, 82.7618}, {-10.6619, 82.1695}, {-2.96197, 80.7875}, {3.15846, 76.0491}, {10.0686, 67.9543}, {13.8199, 60.8467}, {21.9146, 46.6315}, {28.2325, 35.3778}, {33.7606, 21.1626}, {38.1042, 5.76284}, {41.0657, -9.2421}, {42.4477, -24.247}, {42.4477, -55.2441}, {41.8554, -73.2105}, {39.4862, -81.8976}, {37.7093, -82.8847}, {35.735, -80.5155}, {28.8248, -78.9361}, {20.3352, -74.1977}, {10.4635, -69.4593}, {4.34306, -64.5234}, {2.1713, -57.8107}, {2.1713, -44.7801}, {0.591828, -38.4622}, {-4.14657, -33.7238}, {-10.267, -28.5906}, {-19.9412, -22.865}, {-29.418, -15.9548}, {-35.9333, -9.8344}, {-40.2769, -0.160165}, {-42.0538, 13.0679}, {-42.4486, 22.1498}, {-41.264, 31.6266}, {-36.7231, 39.5239}, {-34.3093, 42.8386}, {-23.3, 54.1316}, {-23.9467, 57.9692}, {-25.8642, 64.0057}}, smooth = Smooth.Bezier), Polygon(origin = {-50.19, 0.8}, fillColor = {0, 85, 255}, fillPattern = FillPattern.Solid, points = {{24.9752, 60.463}, {26.2461, 54.2267}, {33.8597, 38.4911}, {35.0394, 35.8207}, {35.5299, 34.6557}, {35.7933, 37.5203}, {35.2985, 48.6417}, {34.2545, 58.39}, {33.2674, 67.5706}, {30.3059, 75.0731}, {24.1854, 80.6012}, {14.3138, 81.5884}, {2.46776, 76.85}, {-6.61418, 66.7809}, {-16.8807, 53.7503}, {-25.5678, 34.5993}, {-32.8728, 14.2636}, {-36.6241, -1.13619}, {-40.1779, -15.7463}, {-40.9676, -32.7255}, {-40.3753, -56.0227}, {-39.9804, -65.1046}, {-37.2164, -74.9763}, {-32.2805, -80.5044}, {-29.9113, -81.689}, {-28.9241, -80.1095}, {-22.8037, -73.1994}, {-8.78595, -64.5123}, {7.20616, -57.2073}, {19.2496, -51.4817}, {27.7392, -39.4383}, {32.6751, -26.0128}, {37.216, -10.613}, {40.9673, 1.23301}, {40.9673, 12.6841}, {39.5852, 23.3455}, {37.216, 31.2429}, {31.4905, 43.4838}, {28.0206, 50.6753}, {26.5003, 54.3994}, {25.6514, 56.7783}, {24.9752, 60.463}}, smooth = Smooth.Bezier)}));
end Lung;
