within SHM.Kotani2005.Examples.FullModel;
model KotaniFullExample
  "Full Kotani model with all components"
  //Ininitial values
  parameter Real conc_cNe = 0.025 "Initial cardiac concentration of Norepinephrine";
  parameter Real conc_vNe = 0.025 "Initial vascular concentration of Norepinephrine";
  parameter Real hypertension = 10 "initial hypertensive factor";
  parameter Real last_beat_p = 100 "Initial value for diastolic blood pressure";
  parameter Real pacemaker = 0 "Initial pacemaker phase";
  parameter Real pressure = 100 "Initial blood pressure";
  parameter Real respiratory_phase = 0.5 "initial respiratory phase";
  //Model parameters (Kotani 2005)
  parameter Real baro_fac_pressure = 0.02 "sensitivity of baroreceptors to blood pressure";
  parameter Real baro_fac_rate = 1.25e-3 "sensitivity of baroreceptors to change in blood pressure";
  parameter Real baro_min_pressure = 50 "minimum static pressure capable of eliciting action potentials";
  parameter Real symp_basic_activity = 0.95 "basic activity level of sympathetic system";
  parameter Real symp_fac_baro = 0.8 "sensitivity of sympathetic system to baroreceptor activity";
  parameter Real symp_fac_resp = 3e-4 "sensitivity of sympathetic system to respiratory phase";
  parameter Real para_basic_activity = 0 "basic activity level of paraympathetic system";
  parameter Real para_factor = 1.1 "scaling factor for parasympathetic neural activity";
  parameter Real para_fac_baro = 0.036 "sensitivity of parasympathetic system to baroreceptor activity";
  parameter Real para_fac_resp = 4.5e-3 "sensitivity of parasympathetic system to respiratory phase";
  parameter Real sinus_basic_duration = 0.6 "basic duration of the pacemaker phase cycle for zero neural activity";
  parameter Real sinus_fac_symp = 1.6 "sensitivity of the sinus node to concentration of cardiac Norepinephrine";
  parameter Real sinus_fac_para = 5.8 "sensitivity of the sinus node to parasympathetic neural activity";
  parameter Real sinus_cNe_sat_val = 2.0 "saturation value for the cardiac concentration of Norepinephrine";
  parameter Real sinus_cNe_sat_exp = 2.0 "saturation exponent for the cardiac concentration of Norepinephrine";
  parameter Real cNe_Tuptake = 2.0 "time until all cardiac Norepinephrine is absorbed by the sinus node";
  parameter Real cNe_fac_symp = 0.7 "increase of cardiac concentration of Norepinephrine for an increase of sympathetic activity by 1.0";
  parameter Real cNe_delay = 1.65 "time taken for a neural signal from the sympathetic system to trigger the release of cardiac Norepinephrine";
  parameter Real sinus_para_delay = 0.5 "time taken for a neural signal from the parasympathetic system to reach the sinus node";
  parameter Real sinus_para_sat_val = 2.5 "saturation value for the parasympathetic neural activity at the sinus node";
  parameter Real sinus_para_sat_exp = 2.0 "saturation exponent for the parasympathetic neural activity at the sinus node";
  parameter Real heart_Tsys = 0.125 "duration of the systole";
  parameter Real heart_S0 = -13.8 "base value for contractility";
  parameter Real heart_fac_cNe = 10 "sensitivity of contractility to cardiac concentration of Norepinephrine";
  parameter Real heart_fac_vNe = 20 "sensitivity of contractility to vascular concentration of Norepinephrine";
  parameter Real heart_fac_Tlast = 45 "sensitivity of contractility to duration of the previous heart beat period";
  parameter Real heart_sat_val = 70 "saturation value for contractility";
  //heart_sat_exp = 2.0 in Kotani 2005
  parameter Real heart_sat_exp = 2.5 "saturation exponent for contractility";
  parameter Real heart_Tzero_base = 2.8 "time until blood pressure (hypothetically) reaches zero during the diastole";
  parameter Real heart_Tzero_fac_vNe = 1.2 "sensitivity of Tzero to vascular concentration of Norepinephrine";
  parameter Real heart_vNe_sat_val = 1.0 "saturation value for vasculat concentration of Norepinephrine that can influence the diastole";
  parameter Real heart_vNe_sat_exp = 1.5 "saturation exponent for vasculat concentration of Norepinephrine that can influence the diastole";
  parameter Real vNe_Tuptake = 2.0 "time until all vascular Norepinephrine is absorbed by the venous system (and other organs)";
  parameter Real vNe_fac_symp = 0.5 "sensitivity of vascular concentration of Norepinephrine to the sympathetic neural activity";
  parameter Real vNe_delay = 4.2 "time taken for vascular Norepinephrine to travel from the sympathetic system to the heart";
  parameter Real vNe_base_activity = 0.2 "amount of tonic firing of sympathetic nerve to vascular smooth muscles";
  parameter Real lung_Tresp = 3.5 "constant respiratory period without influence of baroreceptors";
  parameter Real lung_fac_baro = 0.2 "sensitivity of respiratory phase (during exhalation) to baroreceptor activity";
  parameter Real lung_baro_min = 1.3 "threshold when baroreceptor activity starts to influence respiratory phase (during exhalation)";
  SHM.Kotani2005.Components.SinusNode sinus(initialPhase = pacemaker, T0 = sinus_basic_duration, sfsym = sinus_fac_symp, sfpara = sinus_fac_para, symDelay = cNe_delay, paraDelay = sinus_para_delay, paraSatexp = sinus_para_sat_exp, ccneSatexp = sinus_cNe_sat_exp, paraMax = sinus_para_sat_val, ccneMax = sinus_cNe_sat_val) "the sinus node" annotation(Placement(visible = true, transformation(origin = {-20, -20}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  SHM.Kotani2005.Components.SympatheticSystem symp(v0 = symp_basic_activity, baro_influence = symp_fac_baro, resp_influence = symp_fac_resp) "sympathetic system" annotation(Placement(visible = true, transformation(origin = {-60, 80}, extent = {{-17.1774, -17.1774}, {17.1774, 17.1774}}, rotation = 0)));
  SHM.Kotani2005.Components.ParasympatheticSystem para(v0 = para_basic_activity, baro_influence = para_fac_baro, resp_influence = para_fac_resp, scaling_factor = para_factor) "parasympathetic system" annotation(Placement(visible = true, transformation(origin = {0, 80}, extent = {{-16.7659, -16.7659}, {16.7659, 16.7659}}, rotation = 0)));
  SHM.Kotani2005.Components.HormoneRelease vNeEmit(Tuptake = vNe_Tuptake, prodFac = vNe_fac_symp, triggerDelay = vNe_delay, baseSignal = vNe_base_activity) "emission of vascular Norepinephrine" annotation(Placement(visible = true, transformation(origin = {-20, 40}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  SHM.Kotani2005.Components.NeurotransmitterRelease cNeEmit(Tuptake = cNe_Tuptake, prodFac = cNe_fac_symp, triggerDelay = cNe_delay) "emission of cardiac Norepinephrine" annotation(Placement(visible = true, transformation(origin = {-60, 40}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  SHM.Shared.Components.Compartments.HormoneAmount vNeAmount(initialConcentration = conc_vNe) "amount of vascular Norepinephrine" annotation(Placement(visible = true, transformation(origin = {-20, 8}, extent = {{-8.95759, -8.95759}, {8.95759, 8.95759}}, rotation = 0)));
  SHM.Shared.Components.Compartments.NeurotransmitterAmount cNeAmount(initialConcentration = conc_cNe) "amount of cardiac Norepinephrine" annotation(Placement(visible = true, transformation(origin = {-60, 8}, extent = {{-8.66127, -8.66127}, {8.66127, 8.66127}}, rotation = 0)));
  SHM.Kotani2005.Components.Heart heart(initialS = hypertension, initialPlast = last_beat_p, Tsys = heart_Tsys, S0 = heart_S0, facCcne = heart_fac_cNe, facCvne = heart_fac_vNe, facT = heart_fac_Tlast, maxS = heart_sat_val, satExpS = heart_sat_exp, tauv0 = heart_Tzero_base, facCvneWind = heart_Tzero_fac_vNe, satExpCvne = heart_vNe_sat_exp, maxCvne = heart_vNe_sat_val) "the heart" annotation(Placement(visible = true, transformation(origin = {20, -20}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  SHM.Shared.Components.Compartments.BloodSystem blood(initialPressure = pressure) "main blood system" annotation(Placement(visible = true, transformation(origin = {60, -20}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  SHM.Kotani2005.Components.Baroreceptors baro(p0 = baro_min_pressure, k1 = baro_fac_pressure, k2 = baro_fac_rate) "baroreceptor" annotation(Placement(visible = true, transformation(origin = {60, 20}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  SHM.Kotani2005.Components.SimpleLung lung(initialR = respiratory_phase, Tresp = lung_Tresp, G = lung_fac_baro, nu_trig = lung_baro_min) "the Lung" annotation(Placement(visible = true, transformation(origin = {60, 80}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
equation
  connect(para.signal, sinus.parasympathicus) annotation(Line(points = {{3.35317, 63.2341}, {3.41065, 63.2341}, {3.41065, -9.32245}, {-13.87, -9.32245}, {-13.87, -9.32245}}));
  connect(lung.resp, symp.resp) annotation(Line(points = {{60, 65.3256}, {17.508, 65.3256}, {17.508, 57.7537}, {-27.2852, 57.7537}, {-27.2852, 83.4473}, {-42.7468, 83.4473}, {-42.7468, 83.4473}}));
  connect(lung.resp, para.resp) annotation(Line(points = {{60, 65.3256}, {17.508, 65.3256}, {17.508, 82.3104}, {17.508, 82.3104}}));
  connect(baro.signal, lung.baro) annotation(Line(points = {{64.2, 31.1}, {94.3614, 31.1}, {94.3614, 98.9089}, {47.2944, 98.9089}, {47.2944, 85.9484}, {47.2944, 85.9484}}));
  connect(baro.signal, para.baro) annotation(Line(points = {{64.2, 31.1}, {94.3614, 31.1}, {94.3614, 98.9089}, {-10.0046, 98.9089}, {-10.0046, 90.0412}, {-10.0046, 90.0412}}));
  connect(baro.signal, symp.baro) annotation(Line(points = {{64.2, 31.1}, {94.3614, 31.1}, {94.3614, 98.9089}, {-70.2594, 98.9089}, {-70.2594, 90.7233}, {-70.2594, 90.7233}}));
  connect(blood.vessel, baro.artery) annotation(Line(points = {{45, -20}, {43.8837, -20}, {43.8837, 16.3711}, {43.8837, 16.3711}}));
  connect(heart.artery, blood.vessel) annotation(Line(points = {{27.8, -8.6}, {35.9255, -8.6}, {35.9255, -20.0092}, {43.429, -20.0092}, {43.429, -20.0092}}));
  connect(vNeAmount.con, heart.cvne) annotation(Line(points = {{-20, 16.9576}, {-20.0092, 16.9576}, {-20.0092, 18.6449}, {20.4639, 18.6449}, {20.4639, -5.00229}, {20.4639, -5.00229}}));
  connect(sinus.signal, heart.sinusSignal) annotation(Line(points = {{-20, -32}, {1.36426, -32}, {1.36426, -19.5544}, {12.7331, -19.5544}, {12.7331, -19.5544}}));
  connect(cNeAmount.con, heart.ccne) annotation(Line(points = {{-60, 16.6613}, {-60.0275, 16.6613}, {-60.0275, 19.327}, {-40.0183, 19.327}, {-40.0183, -40.0183}, {6.8213, -40.0183}, {6.8213, -16.8259}, {12.5057, -16.8259}, {12.5057, -16.8259}}));
  connect(cNeAmount.con, sinus.ccne) annotation(Line(points = {{-60, 16.6613}, {-60.0275, 16.6613}, {-60.0275, 19.327}, {-40.0183, 19.327}, {-40.0183, -9.54982}, {-26.1483, -9.54982}, {-26.1483, -9.54982}}));
  connect(vNeEmit.con, vNeAmount.con) annotation(Line(points = {{-14, 25}, {-20.0092, 25}, {-20.0092, 16.8259}, {-20.0092, 16.8259}}));
  connect(cNeEmit.con, cNeAmount.con) annotation(Line(points = {{-45, 40}, {-44.7932, 40}, {-44.7932, 24.5567}, {-60.0275, 24.5567}, {-60.0275, 16.3711}, {-60.0275, 16.3711}}));
  connect(symp.signal, cNeEmit.trigger) annotation(Line(points = {{-56.5645, 62.8226}, {-81.4009, 62.8226}, {-81.4009, 39.7909}, {-75.0343, 39.7909}, {-75.0343, 39.7909}}));
  connect(symp.signal, vNeEmit.trigger) annotation(Line(points = {{-56.5645, 62.8226}, {-35.2434, 62.8226}, {-35.2434, 52.0693}, {-35.2434, 52.0693}}));
annotation(
  Documentation(info="Full Kotani model with standard parameters."),
  Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})),
  Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})),
  experiment(StartTime = 0, StopTime = 10, Interval=0.0001, Tolerance = 1e-6),
  __OpenModelica_simulationFlags(s = "dassl"),
  __MoST_experiment(variableFilter= "blood\\.vessel\\.pressure|lung\\.r|heart\\.tlast|(vNe|cNe|vNe)Amount\\.con\\.concentration|(symp|para|baro)\\.signal\\.activation")
);
end KotaniFullExample;
