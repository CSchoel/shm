within Kotani.Components;
model SympatheticSystem
  Kotani.Components.Basic.NerveInput baro annotation(Placement(visible = true, transformation(origin = {-148.568, 35.5947}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-60, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Kotani.Components.Basic.RespirationInput resp annotation(Placement(visible = true, transformation(origin = {17.8036, 4.7749}, extent = {{-14.85, -10.5}, {14.85, 10.5}}, rotation = 0), iconTransformation(origin = {80, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Kotani.Components.Basic.NerveOutput signal annotation(Placement(visible = true, transformation(origin = {0, -104.614}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {20, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Real baro_influence = 0.8;
  parameter Real resp_influence = 0.0003;
  parameter Real v0 = 0.95;
equation
  signal.activation = max(0, v0 - baro_influence * baro.activation + resp_influence * (1 - resp.phase));
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Polygon(origin = {-24.03, 55.44}, fillColor = {170, 255, 255}, fillPattern = FillPattern.Solid, points = {{16.5305, -32.9369}, {12.5818, -19.314}, {13.3715, -3.32193}, {22.6509, 3.58824}, {36.0764, 4.77284}, {37.0635, 6.15487}, {36.2738, 7.33947}, {23.6381, 5.56257}, {35.2866, 11.8804}, {35.4841, 13.6573}, {34.4969, 14.0522}, {22.256, 6.74717}, {13.3715, 0.824172}, {18.7022, 14.8419}, {25.415, 11.4856}, {26.797, 11.8804}, {27.3893, 13.4599}, {18.8997, 17.0137}, {26.9944, 19.5803}, {27.7842, 21.7521}, {23.6381, 21.3572}, {21.2689, 19.1855}, {17.5176, 18.0009}, {16.333, 27.2802}, {17.9125, 33.993}, {16.333, 35.5724}, {15.7407, 33.5981}, {15.1484, 29.6494}, {14.5561, 25.7008}, {15.7407, 19.5803}, {16.1356, 15.0394}, {10.6075, 0.0344385}, {9.22544, -16.9448}, {2.51271, 0.231872}, {11.1998, 9.90611}, {11.0023, 13.4599}, {8.83058, 10.8933}, {5.27678, 5.16771}, {1.13068, 1.81134}, {0.538376, 17.606}, {8.63314, 24.1213}, {8.04084, 27.8725}, {4.68448, 24.3187}, {1.72298, 20.7649}, {-0.646224, 18.5932}, {-9.72816, 30.834}, {-13.6768, 32.0186}, {-12.8871, 29.6494}, {-10.7153, 27.6751}, {-8.34613, 26.4905}, {-6.17436, 22.9367}, {-3.41029, 18.988}, {-2.22569, 17.606}, {-2.02826, 2.40364}, {-21.3767, 7.14204}, {-25.128, 18.0009}, {-29.4715, 19.9752}, {-28.2869, 17.606}, {-26.1151, 15.6317}, {-24.7331, 10.301}, {-22.9562, 7.14204}, {-33.0253, 10.6958}, {-36.974, 14.4471}, {-37.7637, 12.2753}, {-32.6304, 8.52407}, {-25.128, 6.35231}, {-34.4073, -1.15016}, {-36.1843, -3.32193}, {-33.4201, -4.11167}, {-24.5357, 4.37797}, {-21.5742, 4.77284}, {-2.81799, -0.755295}, {3.30244, -17.5371}, {-4.00259, -18.3269}, {-13.6768, -14.1808}, {-13.282, -17.1423}, {-10.7153, -17.5372}, {-8.14869, -18.9192}, {-3.60772, -20.4986}, {4.09218, -20.1038}, {6.46138, -35.3061}, {16.5305, -32.9369}}, smooth = Smooth.Bezier), Polygon(origin = {65.75, 2.48}, fillColor = {170, 255, 255}, fillPattern = FillPattern.Solid, points = {{-31.5992, 5.61171}, {-16.5942, 1.66305}, {-2.7739, 2.84765}, {-0.404704, 10.1527}, {-5.1431, 15.2859}, {-12.0533, 21.0115}, {-10.4738, 23.1833}, {-10.4738, 22.3936}, {-6.3277, 18.8397}, {-1.5893, 14.6936}, {0.38503, 31.4755}, {3.34653, 30.6858}, {1.56963, 28.7114}, {0.779896, 18.6423}, {0.97733, 13.1142}, {2.5568, 10.3501}, {17.7592, 22.3936}, {16.5746, 33.6473}, {18.7463, 33.4498}, {18.9437, 21.6039}, {25.2616, 34.2396}, {28.0257, 33.4498}, {19.3386, 21.4064}, {34.9359, 21.0115}, {31.3821, 18.2474}, {19.7335, 20.8141}, {4.926, 8.96808}, {1.76706, 3.24252}, {23.8796, 6.20401}, {28.0257, 11.1399}, {29.2103, 5.01941}, {17.5617, 4.03224}, {-0.207274, 0.873313}, {21.5104, -10.9727}, {29.2103, -3.86509}, {31.9744, -4.45739}, {23.4847, -11.1701}, {25.8539, -24.2007}, {24.2745, -34.4673}, {22.1027, -33.875}, {23.6822, -24.5956}, {21.9053, -13.3419}, {7.69006, -6.03685}, {8.87466, -20.0546}, {11.4413, -24.0033}, {9.26953, -24.5956}, {7.09776, -20.6469}, {6.30803, -6.82659}, {-1.78673, -3.07535}, {-7.31483, -4.65482}, {-3.9585, -9.39322}, {-3.76107, -24.2007}, {-6.3277, -24.0033}, {-5.93284, -9.39322}, {-16.1994, -3.07535}, {-34.7581, -2.08819}, {-31.5992, 5.61171}}, smooth = Smooth.Bezier), Polygon(origin = {5.62, 10.18}, fillColor = {170, 197, 255}, fillPattern = FillPattern.Solid, points = {{-21.2176, -22.4199}, {-15.0972, -31.3044}, {3.46154, -24.3942}, {15.505, -31.8967}, {31.1022, -25.1839}, {38.2098, -20.0507}, {35.0509, -5.83546}, {42.7508, 3.24648}, {40.9739, 9.76178}, {34.8534, 24.7667}, {28.733, 31.8743}, {13.9255, 26.5436}, {-7.3973, 19.436}, {-20.4279, 20.0283}, {-38.1969, 10.7489}, {-42.7379, -10.3764}, {-37.4072, -22.6173}, {-26.7458, -18.8661}, {-21.2176, -22.4199}}, smooth = Smooth.Bezier), Polygon(origin = {-25.3, -41.56}, fillColor = {170, 255, 255}, fillPattern = FillPattern.Solid, points = {{-10.4392, 47.6795}, {-20.3108, 34.4515}, {-28.9979, 23.3952}, {-40.8439, 5.82366}, {-43.608, -12.1427}, {-37.4875, -27.9374}, {-18.9288, -35.4399}, {10.6862, -36.6245}, {33.3911, -41.9552}, {42.6704, -52.0243}, {45.0396, -51.8269}, {35.168, -41.1654}, {26.8758, -38.204}, {12.858, -34.8476}, {-0.764916, -33.8604}, {-18.7314, -33.2681}, {-34.3286, -25.9631}, {-40.2516, -12.3402}, {-37.4875, 5.23136}, {-25.2466, 19.2491}, {-13.7955, 27.3439}, {0.617117, 36.4258}, {-3.72642, 51.8256}, {-6.68792, 52.0231}, {-10.4392, 47.6795}}, smooth = Smooth.Bezier), Polygon(origin = {-48.71, -16.87}, fillColor = {85, 170, 255}, fillPattern = FillPattern.Solid, points = {{-2.03262, 6.41041}, {0.928873, 10.754}, {3.10064, 10.9514}, {11.3928, 1.47457}, {10.0108, 0.0925396}, {2.31091, -4.84329}, {-4.40182, -11.556}, {-5.98129, -12.1483}, {-10.1274, -6.62019}, {-10.7197, -5.04072}, {-7.56076, -1.28949}, {-2.03262, 6.41041}}, smooth = Smooth.Bezier), Polygon(origin = {-62.52, -37.02}, fillColor = {85, 170, 255}, fillPattern = FillPattern.Solid, points = {{-3.82625, 2.66598}, {-0.0750089, 9.971}, {1.50446, 12.5376}, {8.01976, 6.81207}, {5.2557, 5.03518}, {1.30703, -3.05959}, {0.122425, -10.3646}, {0.319858, -12.1416}, {-6.98518, -12.9312}, {-7.57748, -10.9569}, {-5.40571, -2.26986}, {-3.82625, 2.66598}}, smooth = Smooth.Bezier), Polygon(origin = {-60.75, -64.74}, fillColor = {85, 170, 255}, fillPattern = FillPattern.Solid, points = {{-7.56426, 4.7184}, {-8.74883, 10.4439}, {-9.53857, 13.4055}, {-1.83869, 13.9977}, {-1.83869, 11.2337}, {-0.456659, 5.11327}, {2.70228, 0.374864}, {9.21758, -4.36354}, {10.9945, -5.35071}, {8.23041, -11.4711}, {5.66378, -10.6814}, {-3.81303, -3.77124}, {-7.56426, 4.7184}}, smooth = Smooth.Bezier), Polygon(origin = {-37.4051, -75.73}, fillColor = {85, 170, 255}, fillPattern = FillPattern.Solid, points = {{0.289564, 3.07171}, {-8.59494, 4.65118}, {-10.9641, 5.63835}, {-14.1231, -0.876956}, {-10.1744, -2.25899}, {3.4485, -4.03589}, {10.7535, -4.82562}, {11.9381, 1.29481}, {9.96377, 2.67685}, {0.289564, 3.07171}}, smooth = Smooth.Bezier), Polygon(origin = {-9.89, -79.27}, fillColor = {85, 170, 255}, fillPattern = FillPattern.Solid, points = {{-4.71695, 4.83685}, {-11.2322, 5.42914}, {-14.5886, 5.23171}, {-15.3783, -0.691293}, {-11.6271, -1.08616}, {-5.11181, -1.67846}, {3.37783, -2.86306}, {9.49826, -4.83739}, {12.0649, -4.83739}, {13.6444, 0.493313}, {10.8803, 2.07278}, {3.18039, 3.65224}, {-4.71695, 4.83685}}, smooth = Smooth.Bezier), Ellipse(origin = {7.11, 7.9}, fillColor = {255, 255, 127}, fillPattern = FillPattern.Solid, extent = {{-19.55, 9.67}, {19.55, -9.67}}, endAngle = 360), Polygon(origin = {-63.5237, 40.629}, fillColor = {170, 0, 0}, fillPattern = FillPattern.Solid, points = {{-0.798549, 9.66202}, {-3.53292, 1.06827}, {-5.09542, -3.22861}, {-3.53292, -7.13486}, {0.763951, -9.08798}, {4.42976, -6.36119}, {4.52002, -1.44084}, {2.7095, 1.21845}, {1.15458, 4.19327}, {-0.798549, 9.66202}}, smooth = Smooth.Bezier), Text(origin = {-0.0025, 78.9025}, extent = {{13.2812, 27.3475}, {51.9531, -46.8787}}, textString = "S")}));
end SympatheticSystem;

