within SHM.SeidelThesis.Examples.FullModel;
model SeidelThesisFullExample "Full baroreflex model as found in Dr. Seidel's PhD thesis"
  SHM.SeidelThesis.Components.Baroreceptors baro(
  	p0=baro_p0,kb=baro_kb,sat_inflection=baro_sat_inflection,saturated=baro_saturated,broadened=baro_broadened,
  	broad_len = baro_broad_len,broad_res=baro_broad_res,broad_eta=baro_broad_eta,broad_sigma=baro_broad_sigma
  ) "baroreceptors" annotation(Placement(visible = true, transformation(origin = {-80, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SHM.SeidelThesis.Components.Lung lung(
    T_r0=lung_T_r0, r_start=lung_r_start, sigma_T_r=lung_sigma_T_r,
    r_noise_last1=lung_r_noise_last1, r_noise_last2=lung_r_noise_last2,
    use_noise=use_noise
  ) "lung" annotation(Placement(visible = true, transformation(origin = {20, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SHM.SeidelThesis.Components.SympatheticSystem sym(
  	base_activity=sym_base_activity,k_baro_resp=sym_k_baro_resp,k_resp=sym_k_resp
  ) "sympathetic system" annotation(Placement(visible = true, transformation(origin = {-40, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SHM.SeidelThesis.Components.ParasympatheticSystem para(
  	base_activity=para_base_activity,k_baro_resp=para_k_baro_resp,k_resp=para_k_resp
  ) "parasympathetic system" annotation(Placement(visible = true, transformation(origin = {60, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SHM.SeidelThesis.Components.NeurotransmitterRelease sNeRelease(
  	tau=sNe_tau,k_ex=sNe_k_ex,k_in=sNe_k_in,delay_ex=sNe_delay_ex,delay_in=sNe_delay_in
  ) "release of Norepinephrine at the sinus node" annotation(Placement(visible = true, transformation(origin = {-20, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SHM.SeidelThesis.Components.NeurotransmitterRelease sAcRelease(
  	with_inhibition=false,tau=sAc_tau,k_ex=sAc_k_ex,delay_ex=sAc_delay_ex
  ) "release of Acetylcholine at the sinus node" annotation(Placement(visible = true, transformation(origin = {60, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SHM.SeidelThesis.Components.HormoneRelease vNeRelease(
  	tau=vNe_tau,k_ex=vNe_k_ex,k_in=vNe_k_in,delay_ex=vNe_delay_ex,delay_in=vNe_delay_in
  ) "release of Norepinephrine at the ventricles" annotation(Placement(visible = true, transformation(origin = {-20, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SHM.SeidelThesis.Components.HormoneRelease wNeRelease(
  	tau=wNe_tau,k_ex=wNe_k_ex,k_in=wNe_k_in,delay_ex=wNe_delay_ex,delay_in=wNe_delay_in
  ) "release of Norepinephrine at the Windkesel arteries" annotation(Placement(visible = true, transformation(origin = {-20, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SHM.Shared.Components.Compartments.NeurotransmitterAmount sNe(initialConcentration=initial_sNe) "postsynaptic concentration of Norepinephrine at the sinus node" annotation(Placement(visible = true, transformation(origin = {20, 40}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  SHM.Shared.Components.Compartments.NeurotransmitterAmount sAc(initialConcentration=initial_sAc) "postsynaptic concentration of Acetylcholine at the sinus node" annotation(Placement(visible = true, transformation(origin = {60, 40}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  SHM.Shared.Components.Compartments.HormoneAmount vNe(initialConcentration=initial_vNe) "vascular concentration of Norepinephrine at the ventricles" annotation(Placement(visible = true, transformation(origin = {20, 0}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  SHM.Shared.Components.Compartments.HormoneAmount wNe(initialConcentration=initial_wNe) "vascular concentration of Norepinephrine at the  Windkesel arteries" annotation(Placement(visible = true, transformation(origin = {20, 20}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  SHM.SeidelThesis.Components.SinusNode sinus(T_0=sinus_T_0,k_sNe=sinus_k_sNe,k_sAc=sinus_k_sAc) "sinus node" annotation(Placement(visible = true, transformation(origin = {-20, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SHM.SeidelThesis.Components.Heart heart(
  	T_refrac=heart_T_refrac,T_av=heart_T_av,T_avc0=heart_T_avc0,tau_avc=heart_tau_avc,k_avc_t=heart_k_avc_t,
  	initial_T = heart_initial_T,initial_t_last=heart_initial_t_last,tau_sys=heart_tau_sys,S_0=heart_S_0,
  	k_S_vNe=heart_k_S_vNe,k_S_mresp=heart_k_S_mresp,T_hat=heart_T_hat,compliance=heart_compliance,
  	tau_wind0=heart_tau_wind0,k_wind_wNe=heart_k_wind_wNe,p_wind0=heart_p_wind0,initial_S=heart_initial_S,
    initial_T_avc=heart_initial_T_avc
  ) "the heart" annotation(Placement(visible = true, transformation(origin = {0, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SHM.Shared.Components.Compartments.BloodSystem blood(initialPressure=initial_p) "whole blood system of the body" annotation(Placement(visible = true, transformation(origin = {60, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  inner Modelica.Blocks.Noise.GlobalSeed globalSeed(enableNoise=use_noise) "global seed for all noise terms in the model";

  parameter Real initial_p = 100 "initial blood pressure";

  parameter Real initial_sNe = 0.12 "initial postsynaptic concentration of Norepinephrine at the sinus node";
  parameter Real initial_sAc = 0.5 "initial postsynaptic concentration of Acetylcholine at the sinus node";
  parameter Real initial_vNe = 0.12 "initial vascular concentration of Norepinephrine at the ventricles";
  parameter Real initial_wNe = 0.12 "initial vascular concentration of Norepinephrine at the Windkesel arteries";

  parameter Real sinus_T_0 = 0.9 "heart period for denervated heart";
  parameter Real sinus_k_sNe = 0.6 "sensitivity of sinus node to concentration of Norepinephrine";
  parameter Real sinus_k_sAc = 0.2 "sensitivity of sinus node to concentration of Acetylcholine";

  parameter Real sNe_tau = 2 "time until concentration drops to zero without any nervous signal";
  parameter Real sNe_k_ex = 0.014 "scaling factor for excitatory influence of sympathetic system on sinoatrial concentration of Norepinephrine";
  parameter Real sNe_k_in = 0.006 "scaling factor for inhibitory influence of parasympathetic system on sinoatrial concentration of Norepinephrine";
  parameter Real sNe_delay_ex = 2 "time until excitatory signal from sympathetic system triggers release of sinoatrial Norepinephrine";
  parameter Real sNe_delay_in = 0.4 "time until inhibitory signal from parasympathetic system is recognized at the sinus node";
  parameter Real vNe_tau = 4 "time until concentration of Norepinephrine at the sinus node drops to zero without any nervous signal";
  parameter Real vNe_k_ex = 0.014 "scaling factor for excitatory influence of sympathetic system on ventricular concentration of Norepinephrine";
  parameter Real vNe_k_in = 0.006 "scaling factor for inhibitory influence of parasympathetic system on ventricular concentration of Norepinephrine";
  parameter Real vNe_delay_ex = 2 "time until excitatory signal from sympathetic system triggers release of ventricular Norepinephrine";
  parameter Real vNe_delay_in = 0.4 "time until inhibitory signal from parasympathetic system is recognized at the ventricles";
  parameter Real wNe_tau = 4 "time until concentration of Norepinephrine at the windkessel Arteries drops to zero without any nervous signal";
  parameter Real wNe_k_ex = 0.014 "scaling factor for excitatory influence of sympathetic system on concentration of Norepinephrine in the Windkessel arteries";
  parameter Real wNe_k_in = 0 "scaling factor for inhibitory influence of parasympathetic system on concentration of Norepinephrine in the Windkessel arteries";
  parameter Real wNe_delay_ex = 3 "time until excitatory signal from sympathetic system triggers release of Norepinephrine at the Windkessel arteries";
  parameter Real wNe_delay_in = 0.4 "time until inhibitory signal from parasympathetic system is recognized at the Windkessel arteries";
  parameter Real sAc_tau = 0.05 "time until concentration of Acetylcholine at the sinus node drops to zero without any nervous signal";
  parameter Real sAc_k_ex = 0.005 "scaling factor for excitatory influence of parasympathetic system on sinoatrial concentration of Acetylcholine";
  parameter Real sAc_delay_ex = sNe_delay_in "time until excitatory signal of parasympathetic system triggers release of sinoatrial Acetylcholine";

  parameter Real sym_base_activity = 50 "base activity of the sympathetic nervous system";
  parameter Real sym_k_baro_resp = 0.38 "sensitivity of sympathetic system to correlated signal of baroreceptors and respiratory neurons";
  parameter Real sym_k_resp = 30 "sensitivity of sympathetic system to respiratory neurons";
  parameter Real para_base_activity = 10 "base activity of the parasympathetic nervous system";
  parameter Real para_k_baro_resp = 0.38 "sensitivity of parasympathetic system to correlated signal of baroreceptors and respiratory neurons";
  parameter Real para_k_resp = 30 "sensitivity of parasympathetic system to respiratory neurons";

  parameter Real lung_T_r0 = 4 "respiratory period";
  parameter Real lung_r_start = 0.16 "respiratory phase shift in seconds";
  parameter Real lung_sigma_T_r = 0.2 "sigma for gaussian noise for respiratory phase fluctuations";
  parameter Real lung_r_noise_last1 = 0.5 "ratio of last noise value that is kept";
  parameter Real lung_r_noise_last2 = 0.25 "ratio of second last noise value that is kept";

  parameter Real baro_p0 = 60 "minimum blood pressure needed to generate baroreceptor signal";
  parameter Real baro_kb = 0.06 "sensitivity of baroreceptors to blood pressure increase";
  parameter Real baro_sat_inflection = 120 "point of inflection for the baroreceptor saturation";
  parameter Boolean baro_saturated = true "if true, saturation function is applied to raw baroreceptor signal";
  parameter Boolean baro_broadened = true "if true, boradening is applied to (saturated if baro_saturated=true) baroreceptor signal";
  parameter Real baro_broad_len = 0.1 "broadening length of baroreceptor signal in seconds";
  parameter Real baro_broad_res = 1000 "broadening calculation steps of baroreceptor signal per second";
  parameter Real baro_broad_eta = 0.01 "broadening eta for baroreceptors";
  parameter Real baro_broad_sigma = 0.001 "broadening sigma for baroreceptors";

  parameter Real heart_T_refrac = 0.22 "refractory period that has to pass until a signal from the sinus node can take effect again";
  parameter Real heart_T_av = 1.7 "time that can pass after the beginning of a systole until the av node initiates a contraction";
  parameter Real heart_T_avc0 = 0.09 "base value for atrioventricular conduction time";
  parameter Real heart_tau_avc = 0.11 "reference value for atrioventricular conduction time"; //TODO find better description
  parameter Real heart_k_avc_t = 0.78 "sensitivity of the atrioventricular conduction time to the time passed since the last ventricular conduction";
  parameter Real heart_tau_sys = 0.125 "duration of systole";
  parameter Real heart_S_0 = 110 "base value for contractility";
  parameter Real heart_k_S_vNe = 110 "sensitivity of contractility to Norepinephrine concentration in the ventricles";
  parameter Real heart_k_S_mresp = 0 "sensitivity of contractility to mechanical pressure from respiration";
  parameter Real heart_T_hat = 1 "if RR-Interval is shorter than this time, contractility for the next beat decreases";
  parameter Real heart_compliance = 2 "arterial compliance in ml/mmHg";
  parameter Real heart_tau_wind0 = 1.3 "base value for windkessel relaxation";
  parameter Real heart_k_wind_wNe = 0.8 "sensitivity of windkessel relaxation to Norepinephrine in Windkesel arteries";
  parameter Real heart_p_wind0 = 0 "minimum blood pressure that remains even if the heart would completely cease to beat";
  parameter Real heart_sigma_T = 0.02 "sigma for gaussian noise for heart period fluctuations";
  parameter Real heart_r_noise_last = 0.9 "how much of heart period noise is kept between beats";
  parameter Real heart_initial_T = 1 "initial value for T";
  parameter Real heart_initial_t_last = -heart_initial_T "initial value for last ventricular contraction time";
  parameter Real heart_initial_T_avc = 0.15 "initial value for atrioventricular conduction delay";
  parameter Real heart_initial_S = 120 "initial value for contractility";

  parameter Boolean use_noise = false "if true, noise is added to heart and respiratory period";
equation
  connect(baro.artery,blood.vessel) annotation(Line(points = {{50, -60}, {18.6047, -60}, {18.6047, -89.8032}, {-90.5188, -89.8032}, {-90.5188, 57.6029}, {-90.5188, 57.6029}}));
  connect(heart.artery,blood.vessel) annotation(Line(points = {{5.2, -52.4}, {49.7317, -52.4}, {49.7317, -60.1073}, {49.7317, -60.1073}}));
  connect(baro.signal,sym.baro) annotation(Line(points = {{-77.2, 67.4}, {-77.6386, 67.4}, {-77.6386, 85.1521}, {-45.7961, 85.1521}, {-45.7961, 85.1521}}));
  connect(baro.signal,para.baro) annotation(Line(points = {{-77.2, 67.4}, {-77.6386, 67.4}, {-77.6386, 94.0966}, {54.025, 94.0966}, {54.025, 86.5832}, {54.025, 86.5832}}));
  connect(lung.signal,sym.resp) annotation(Line(points = {{20, 72}, {-7.8712, 72}, {-7.8712, 81.932}, {-30.4114, 81.932}, {-30.4114, 81.932}}));
  connect(lung.signal,para.resp) annotation(Line(points = {{20, 72}, {70.1252, 72}, {70.1252, 82.2898}, {70.1252, 82.2898}}));
  connect(lung.resp,heart.mresp) annotation(Line(points = {{4, -62}, {13.399, -62}, {13.399, -55.0171}, {29.8432, -55.0171}, {29.8432, 77.5517}, {29.8432, 77.5517}}));
  connect(sym.signal,sNeRelease.excitation) annotation(Line(points = {{-38, 70}, {-37.9249, 70}, {-37.9249, 59.3918}, {-30.0537, 59.3918}, {-30.0537, 59.3918}}));
  connect(sym.signal,vNeRelease.excitation) annotation(Line(points = {{-38, 70}, {-37.9249, 70}, {-37.9249, 18.6047}, {-29.3381, 18.6047}, {-29.3381, 18.6047}}));
  connect(sym.signal,wNeRelease.excitation) annotation(Line(points = {{-38, 70}, {-37.9249, 70}, {-37.9249, 39.356}, {-30.0537, 39.356}, {-30.0537, 39.356}}));
  connect(para.signal,sAcRelease.excitation) annotation(Line(points = {{62, 70}, {42.2182, 70}, {42.2182, 59.7496}, {50.4472, 59.7496}, {50.4472, 59.7496}}));
  connect(para.signal,sNeRelease.inhibition) annotation(Line(points = {{62, 70}, {-34.1065, 70}, {-34.1065, 63.9497}, {-30.8583, 63.9497}, {-30.8583, 63.9497}}));
  connect(para.signal,vNeRelease.inhibition) annotation(Line(points = {{62, 70}, {-34.1065, 70}, {-34.1065, 23.9558}, {-30.0462, 23.9558}, {-30.0462, 23.9558}}));
  connect(para.signal,wNeRelease.inhibition) annotation(Line(points = {{62, 70}, {-34.1065, 70}, {-34.1065, 43.4452}, {-30.0462, 43.4452}, {-30.0462, 43.4452}}));
  connect(sNeRelease.con,sNe.con) annotation(Line(points = {{-10, 60}, {20.3936, 60}, {20, 50}, {20, 45}}));
  connect(vNeRelease.con,vNe.con) annotation(Line(points = {{-10, 20}, {2.14669, 20}, {2.14669, 11.0912}, {20.3936, 11.0912}, {20.3936, 4.65116}, {20.3936, 4.65116}}));
  connect(wNeRelease.con,wNe.con) annotation(Line(points = {{-10, 40}, {3.9356, 40}, {3.9356, 31.4848}, {20.0358, 31.4848}, {20.0358, 24.6869}, {20.0358, 24.6869}}));
  connect(sAcRelease.con,sAc.con) annotation(Line(points = {{70, 60}, {75.4919, 60}, {75.4919, 45.0805}, {59.7496, 45.0805}, {59.7496, 45.0805}}));
  connect(sinus.sAc,sAc.con) annotation(Line(points = {{-16, -33}, {50.1447, -33}, {50.1447, 47.7085}, {60.0924, 47.7085}, {60.0924, 45.0693}, {60.0924, 45.0693}}));
  connect(sinus.sNe,sNe.con) annotation(Line(points = {{-24, -33}, {-23.7528, -33}, {-23.7528, -26.3919}, {44.8663, -26.3919}, {44.8663, 47.7085}, {20.0985, 47.7085}, {20.0985, 45.0693}, {20.0985, 45.0693}}));
  connect(heart.vNe,vNe.con) annotation(Line(points = {{0, -68}, {0, -68}, {0, -74.1005}, {-37.1517, -74.1005}, {-37.1517, 7.91758}, {20.3015, 7.91758}, {20.3015, 5.07537}, {20.3015, 5.07537}}));
  connect(heart.wNe,wNe.con) annotation(Line(points = {{0, -52}, {0.40603, -52}, {0.40603, -12.5869}, {27.001, -12.5869}, {27.001, 28.8281}, {20.0985, 28.8281}, {20.0985, 25.1739}, {20.0985, 25.1739}}));
  connect(heart.sinus,sinus.signal) annotation(Line(points = {{-20, -48}, {-20.3015, -48}, {-20.3015, -59.8894}, {-5.27839, -59.8894}, {-5.27839, -59.8894}}));
annotation(
  experiment(StartTime=0, StopTime=200, Tolerance=1e-6, Interval=0.001),
  __OpenModelica_simulationFlags(s = "dassl"),
  __MoST_experiment(variableFilter= "blood\\.vessel\\.pressure|lung\\.resp\\.phase|heart\\.contraction\\.T|(sNe|vNe|wNe|sAc)\\.con\\.concentration|(sym|para|baro|lung)\\.signal\\.activation")
);
end SeidelThesisFullExample;
