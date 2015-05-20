within SHM.SeidelThesis.Components;
model Heart "Main heart model"
  SHM.Shared.Connectors.RespirationInput mresp "mechanical respiratory influence" annotation(Placement(visible = true, transformation(origin = {40, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {40, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SHM.Shared.Connectors.SubstanceConcentration vNe "concentration of Norepinephrine in the ventricles" annotation(Placement(visible = true, transformation(origin = {0, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SHM.Shared.Connectors.SubstanceConcentration wNe "concentration of Norepinephrine in the Windkessel arteries" annotation(Placement(visible = true, transformation(origin = {0, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SHM.Shared.Connectors.DiscreteSignal sinus "sinus node signal" annotation(Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-50, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SHM.Shared.Connectors.BloodVessel artery "connection to blood system" annotation(Placement(visible = true, transformation(origin = {40, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {52, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Real T_refrac = 0.22 "refractory period that has to pass until a signal from the sinus node can take effect again";
  parameter Real T_av = 1.7 "time that can pass after the beginning of a systole until the av node initiates a contraction";
  parameter Real T_avc0 = 0.09 "base value for atrioventricular conduction time";
  parameter Real tau_avc = 0.11 "reference time for atrioventricular conduction time"; //TODO find better description
  parameter Real k_avc_t = 0.78 "sensitivity of the atrioventricular conduction time to the time passed since the last ventricular conduction";
  parameter Real initial_T = T_hat "initial value for T";
  parameter Real initial_t_last = 0 "initial value for last ventricular contraction time";
  parameter Real initial_T_avc = 0.15 "initial value for atrioventricular conduction delay";
  SHM.SeidelThesis.Components.Contraction contraction(
  	T_refrac=T_refrac,T_av=T_av,initial_T=initial_T,initial_cont_last=initial_t_last,
  	initial_T_avc=initial_T_avc,k_avc_t=k_avc_t,T_avc0=T_avc0,tau_avc=tau_avc
  ) "contraction model used to calculate the actual time of ventricular contraction";
  parameter Real tau_sys = 0.125 "duration of systole";
  parameter Real S_0 = 110 "base value for contractility";
  parameter Real k_S_vNe = 110 "sensitivity of contractility to Norepinephrine concentration in the ventricles";
  parameter Real k_S_mresp = 0 "sensitivity of contractility to mechanical pressure from respiration";
  parameter Real T_hat = 1 "if RR-Interval is shorter than this time, contractility for the next beat decreases";
  parameter Real compliance = 2 "arterial compliance in ml/mmHg";
  parameter Real tau_wind0 = 1.3 "base value for windkessel relaxation";
  parameter Real k_wind_wNe = 0.8 "sensitivity of windkessel relaxation to Norepinephrine in Windkessel arteries";
  parameter Real p_wind0 = 7 "minimum pressure that remains even if the heart totally stops beating";
  parameter Real initial_S = S_0 "initial value for contractility";
  Real tau_wind "windkessel relaxation (time until blood pressure hypothetically drops to zero during diastole)";
  discrete Real S "Contractility";
  Real pdia "diastolic blood pressure";
  Real psys "systolic blood pressure";
  Boolean systole "if true, the system is currently in a systole";
  Real progress "progress of systole (rising from 0 to 1 linearly)";
initial equation
  psys = pdia "there is already a connection between one of these variables and artery.pressure";
  S = initial_S;
equation
  contraction.signal = sinus.s;
  progress = (time - contraction.cont_last) / tau_sys;
  //der(psys) is a manual differentiation of the following equation from the SHM
  //psys = plast + S/compliance * progress * exp(1 - progress);
  der(psys) = 1 / tau_sys * S/compliance * (1 - progress) * exp(1 - progress);
  der(pdia) = -(pdia-p_wind0) / tau_wind;
  tau_wind = tau_wind0 + k_wind_wNe * wNe.concentration;
  systole = time - contraction.cont_last < tau_sys;
  when systole then
    S = S_0 + (k_S_vNe * vNe.concentration + k_S_mresp * mresp.phase) * (1 - (1 - min(1,contraction.T/T_hat))^2);
    reinit(psys,pdia);
  end when;
  when not systole then //end of systole
    reinit(pdia,psys);
  end when;
  artery.pressure = if systole then psys else pdia;
  
  vNe.rate = 0;
  wNe.rate = 0;
annotation(Documentation(info="<html>
  <p>Models the heart itself including the function of the AV-Node and the Windkessel arteries.</p>
  <p>The heart switches between a formula for the systolic blood pressure rate and the diastolic blood pressure rate based on the following rules:</p>
  <ul>
    <li>When a ventricular contraction is triggered, switch to systole.
    <li>After <b>tau_sys</b> seconds switch back to diastole.
  </ul>
</html>"), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Polygon(origin = {2.6654, -32.9828}, fillColor = {85, 0, 0}, fillPattern = FillPattern.Solid, points = {{-47.0876, -6.30646}, {-34.4518, -23.4832}, {-20.434, -33.7497}, {-0.690711, -39.4753}, {18.6578, -43.8188}, {33.0704, -44.2137}, {40.7703, -35.5266}, {45.3113, -22.1011}, {46.101, -5.51673}, {41.3626, 10.0805}, {35.2422, 27.6521}, {28.9243, 33.7725}, {18.8552, 31.4033}, {9.18096, 42.8545}, {-6.41628, 44.2365}, {-23.3955, 40.2878}, {-30.7006, 33.9699}, {-39.7825, 19.9522}, {-46.8901, 4.74981}, {-47.0876, -6.30646}}, smooth = Smooth.Bezier), Polygon(origin = {-35.51, -9.31}, fillColor = {255, 170, 127}, fillPattern = FillPattern.Solid, points = {{-8.12542, -32.1477}, {-11.4818, -30.1733}, {-15.6279, -19.3145}, {-18.5894, -4.90188}, {-18.392, 10.4979}, {-15.8253, 21.7516}, {-12.2715, 29.649}, {-5.95365, 32.0182}, {1.54882, 31.031}, {2.93085, 29.8464}, {1.74625, 23.1337}, {4.51032, 21.9491}, {17.3435, 20.9619}, {18.7255, 18.5927}, {14.1846, 12.8671}, {5.49749, 1.02112}, {-2.39985, -12.2069}, {-6.54595, -21.4863}, {-7.33568, -27.8041}, {-8.12542, -32.1477}}, smooth = Smooth.Bezier), Polygon(origin = {23, 8.08}, fillColor = {255, 170, 127}, fillPattern = FillPattern.Solid, points = {{-7.20645, 8.50297}, {-9.97052, 5.1466}, {-10.9577, 2.97483}, {-10.5628, -1.76357}, {-8.19362, -1.3687}, {-2.86292, -9.0686}, {2.46778, -10.2532}, {10.9574, -8.87117}, {10.5626, -3.93534}, {7.40362, -0.381536}, {5.23185, 7.12093}, {-1.08602, 10.2799}, {-7.20645, 8.50297}}, smooth = Smooth.Bezier), Polygon(origin = {21.68, 24.99}, fillColor = {170, 170, 255}, fillPattern = FillPattern.Solid, points = {{-21.2855, 17.6533}, {-14.3754, 11.5329}, {-11.8088, 7.3868}, {-5.6883, 10.5457}, {12.0807, 9.95344}, {24.9139, 7.3868}, {33.4035, 5.6099}, {33.6009, -2.48487}, {33.2061, -7.81557}, {30.6394, -10.7771}, {17.4114, -7.81557}, {2.80134, -5.44637}, {-6.2806, -8.013}, {-9.8344, -14.9232}, {-9.43953, -17.4898}, {-16.1523, -15.5155}, {-27.8008, -15.9103}, {-33.7238, -17.2924}, {-30.3675, -11.1719}, {-28.3931, -3.66947}, {-27.0111, 0.871502}, {-30.3675, 10.7432}, {-21.2855, 17.6533}}, smooth = Smooth.Bezier), Polygon(points = {{13.8203, 34.5508}, {13.8203, 34.5508}, {13.8203, 34.5508}}), Polygon(origin = {1.93257, 47.48}, fillColor = {170, 0, 0}, fillPattern = FillPattern.Solid, points = {{-13.3879, -38.797}, {-9.83413, -25.7664}, {-8.05723, -14.1178}, {-4.306, -7.99741}, {1.617, -6.61538}, {6.3554, -7.40511}, {8.32974, -12.3409}, {8.7246, -15.105}, {19.9783, -11.7486}, {31.4295, -13.9204}, {30.8371, -10.1692}, {29.4551, -0.297513}, {25.309, 9.57416}, {22.3475, 13.5228}, {25.1115, 16.2869}, {32.0218, 22.6047}, {36.9576, 25.9611}, {34.9832, 29.1201}, {32.8115, 30.6995}, {30.8371, 31.0944}, {21.9526, 23.5919}, {18.004, 18.6561}, {22.5449, 24.3817}, {24.7167, 28.1329}, {26.8885, 30.6995}, {26.0987, 32.8713}, {23.927, 35.0431}, {21.1629, 35.6354}, {19.386, 34.2533}, {12.2784, 26.5534}, {7.54, 23.1971}, {2.01187, 22.6048}, {-2.5291, 24.3817}, {-5.29317, 26.1586}, {-6.87263, 31.2918}, {-8.84697, 37.2148}, {-10.229, 41.3609}, {-10.6239, 42.1507}, {-12.0059, 41.7558}, {-15.3622, 40.0776}, {-18.7186, 38.3994}, {-17.7315, 32.6739}, {-16.7443, 27.5406}, {-16.6456, 23.5919}, {-16.5469, 19.6433}, {-23.0622, 8.38956}, {-28.3929, -3.06158}, {-31.9467, -13.5255}, {-34.5133, -26.7536}, {-35.8953, -32.4792}, {-36.2902, -35.4407}, {-21.0878, -36.033}, {-19.9032, -37.6124}, {-21.8776, -42.1534}, {-16.5469, -40.5739}, {-13.3879, -38.797}}, smooth = Smooth.Bezier), Polygon(origin = {31.46, 12.94}, fillColor = {170, 0, 0}, fillPattern = FillPattern.Solid, points = {{0.0215969, -6.10312}, {0.581742, -5.655}, {8.31174, -5.76703}, {8.87189, -5.20688}, {8.87189, -3.41442}, {8.87189, 0.618623}, {8.31174, 1.62688}, {7.97566, 2.52312}, {5.8471, 2.52312}, {1.14189, 2.52312}, {1.47797, 3.08326}, {2.37421, 3.41935}, {7.7516, 4.20355}, {1.70203, 5.32384}, {-4.57159, 5.88399}, {-13.9032, 5.48912}, {-13.0336, 4.42208}, {-7.82043, 4.14477}, {-4.90768, 2.97123}, {-3.33927, 1.17877}, {-1.77087, -1.95804}, {-1.32275, -3.63848}, {0.0215969, -6.10312}}, smooth = Smooth.Bezier), Polygon(origin = {-27.04, 52.21}, fillColor = {170, 255, 255}, fillPattern = FillPattern.Solid, points = {{-18.8871, -30.9245}, {-17.2066, -22.8584}, {-15.9743, -13.56}, {-14.5179, -0.116508}, {-13.8458, 6.4932}, {-13.1736, 13.1029}, {-12.0533, 18.7044}, {-11.045, 24.5299}, {-9.92476, 30.6915}, {-9.58867, 32.0358}, {-6.89997, 32.82}, {-4.32331, 33.0441}, {-1.29852, 32.2599}, {0.38191, 31.1396}, {0.605968, 30.6915}, {1.05408, 20.8329}, {1.39017, 16.7999}, {2.17437, 15.9036}, {6.43148, 18.7044}, {10.6886, 21.6171}, {13.1532, 22.5133}, {16.178, 22.1773}, {17.7464, 20.1607}, {18.7547, 17.6961}, {18.8667, 14.5593}, {17.4103, 13.2149}, {6.5435, 5.59697}, {3.96684, 2.12407}, {3.51872, -1.79694}, {-0.402293, -11.5435}, {-3.20302, -21.178}, {-4.99548, -29.3561}, {-5.66766, -33.053}, {-18.8871, -30.9245}}, smooth = Smooth.Bezier), Ellipse(origin = {50.8947, 23.2777}, fillPattern = FillPattern.Solid, extent = {{-3.34, 7.18}, {3.34, -7.18}}, endAngle = 360), Ellipse(origin = {-9.66, 67.86}, rotation = 20, fillPattern = FillPattern.Solid, extent = {{-2.97, 6.19}, {0, -0.74}}, endAngle = 360)}));
end Heart;
