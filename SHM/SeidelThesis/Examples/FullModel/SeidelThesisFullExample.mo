within SHM.SeidelThesis.Examples.FullModel;
model SeidelThesisFullExample "Full baroreflex model as found in Dr. Seidel's PhD thesis"
  SHM.SeidelThesis.Components.Baroreceptors baro(
  	p0=baro_p0,kb=baro_kb,sat_inflection=baro_sat_inflection,saturated=baro_saturated,broadened=baro_broadened,
  	broad_len = baro_broad_len,broad_res=baro_broad_res,broad_eta=baro_broad_eta,broad_sigma=baro_broad_sigma
  ) "baroreceptors";
  SHM.SeidelThesis.Components.Lung lung(T_r=lung_T_r,r_start=lung_r_start) "lung";
  SHM.SeidelThesis.Components.SympatheticSystem sym(
  	base_activity=sym_base_activity,k_baro_resp=sym_k_baro_resp,k_resp=sym_k_resp
  ) "sympathetic system";
  SHM.SeidelThesis.Components.ParasympatheticSystem para(
  	base_activity=para_base_activity,k_baro_resp=para_k_baro_resp,k_resp=para_k_resp
  ) "parasympathetic system";
  SHM.SeidelThesis.Components.SubstanceEmission sNeEmit(
  	tau=sNe_tau,k_ex=sNe_k_ex,k_in=sNe_k_in,delay_ex=sNe_delay_ex,delay_in=sNe_delay_in
  ) "emission of Norepinephrine at the sinus node";
  SHM.SeidelThesis.Components.SubstanceEmission sAcEmit(
  	with_inhibition=false,tau=sAc_tau,k_ex=sAc_k_ex,delay_ex=sAc_delay_ex
  ) "emission of Acetylcholine at the sinus node";
  SHM.SeidelThesis.Components.SubstanceEmission vNeEmit(
  	tau=vNe_tau,k_ex=vNe_k_ex,k_in=vNe_k_in,delay_ex=vNe_delay_ex,delay_in=vNe_delay_in
  ) "emission of Norepinephrine at the ventricles";
  SHM.SeidelThesis.Components.SubstanceEmission rNeEmit(
  	tau=rNe_tau,k_ex=rNe_k_ex,k_in=rNe_k_in,delay_ex=rNe_delay_ex,delay_in=rNe_delay_in
  ) "emission of Norepinephrine at the resistance vessels";
  SHM.Shared.Components.Compartments.NeurotransmitterAmount sNe(initialConcentration=initial_sNe) "postsynaptic concentration of Norepinephrine at the sinus node";
  SHM.Shared.Components.Compartments.NeurotransmitterAmount sAc(initialConcentration=initial_sAc) "postsynaptic concentration of Acetylcholine at the sinus node";
  SHM.Shared.Components.Compartments.HormoneAmount vNe(initialConcentration=initial_vNe) "vascular concentration of Norepinephrine at the ventricles";
  SHM.Shared.Components.Compartments.HormoneAmount rNe(initialConcentration=initial_rNe) "vascular concentration of Norepinephrine at the resistance vessels";
  SHM.SeidelThesis.Components.SinusNode sinus(T_0=sinus_T_0,k_sNe=sinus_k_sNe,k_sAc=sinus_k_sAc) "sinus node";
  SHM.SeidelThesis.Components.Heart heart(
  	T_refrac=heart_T_refrac,T_av=heart_T_av,T_avc0=heart_T_avc0,tau_av=heart_tau_av,k_av_t=heart_k_av_t,
  	initial_T = heart_initial_T,initial_t_last=heart_initial_t_last,tau_sys=heart_tau_sys,S_0=heart_S_0,
  	k_S_vNe=heart_k_S_vNe,k_S_mresp=heart_k_S_mresp,T_hat=heart_T_hat,compliance=heart_compliance,
  	tau_wind0=heart_tau_wind0,k_wind_rNe=heart_k_wind_rNe,p_wind0=heart_p_wind0
  ) "the heart";
  SHM.Shared.Components.Compartments.BloodSystem blood(initialPressure=initial_p) "whole blood system of the body";
  
  parameter Real initial_p = 70 "initial blood pressure";
  
  parameter Real initial_sNe = 0 "initial postsynaptic concentration of Norepinephrine at the sinus node";
  parameter Real initial_sAc = 0 "initial postsynaptic concentration of Acetylcholine at the sinus node";
  parameter Real initial_vNe = 0 "initial vascular concentration of Norepinephrine at the ventricles";
  parameter Real initial_rNe = 0 "initial vascular concentration of Norepinephrine at the resistance vessels";
  
  parameter Real sinus_T_0 = 0.9 "heart period for denervated heart";
  parameter Real sinus_k_sNe = 1.2 "sensitivity of sinus node to concentration of Norepinephrine";
  parameter Real sinus_k_sAc = 0.2 "sensitivity of sinus node to concentration of Acetylcholine";
  
  parameter Real sNe_tau = 2 "time until concentration drops to zero without any nervous signal";
  parameter Real sNe_k_ex = 0.014 "scaling factor for excitatory influence";
  parameter Real sNe_k_in = 0.006 "scaling factor for inhibitory influence";
  parameter Real sNe_delay_ex = 2 "time until excitatory signal triggers substance release";
  parameter Real sNe_delay_in = 0.4 "time until inhibitory signal is recognized";
  parameter Real vNe_tau = 4 "time until concentration drops to zero without any nervous signal";
  parameter Real vNe_k_ex = 0.014 "scaling factor for excitatory influence";
  parameter Real vNe_k_in = 0.006 "scaling factor for inhibitory influence";
  parameter Real vNe_delay_ex = 2 "time until excitatory signal triggers substance release";
  parameter Real vNe_delay_in = 0.4 "time until inhibitory signal is recognized";
  parameter Real rNe_tau = 4 "time until concentration drops to zero without any nervous signal";
  parameter Real rNe_k_ex = 0.014 "scaling factor for excitatory influence";
  parameter Real rNe_k_in = 0 "scaling factor for inhibitory influence";
  parameter Real rNe_delay_ex = 3 "time until excitatory signal triggers substance release";
  parameter Real rNe_delay_in = 0.4 "time until inhibitory signal is recognized";
  parameter Real sAc_tau = 0.05 "time until concentration drops to zero without any nervous signal";
  parameter Real sAc_k_ex = 0.005 "scaling factor for excitatory influence";
  parameter Real sAc_delay_ex = sNe_delay_in "time until excitatory signal triggers substance release";
  
  parameter Real sym_base_activity = 50 "base activity of the nervous system";
  parameter Real sym_k_baro_resp = 0.4 "sensitivity to correlated signal of baroreceptors and respiratory neurons";
  parameter Real sym_k_resp = 30 "sensitivity to respiratory neurons";
  parameter Real para_base_activity = 10 "base activity of the nervous system";
  parameter Real para_k_baro_resp = 0.4 "sensitivity to correlated signal of baroreceptors and respiratory neurons";
  parameter Real para_k_resp = 30 "sensitivity to respiratory neurons";
  
  parameter Real lung_T_r = 4 "respiratory period";
  parameter Real lung_r_start = 0.16 "respiratory phase shift in seconds";
  
  parameter Real baro_p0 = 60 "minimum blood pressure needed to generate signal";
  parameter Real baro_kb = 0.06 "sensitivity of baroreceptors to blood pressure increase";
  parameter Real baro_sat_inflection = 120 "point of inflection for the saturation function";
  parameter Boolean baro_saturated = true "if true, saturation function is applied to raw baroreceptor signal";
  parameter Boolean baro_broadened = true "if true, boradening is applied to (saturated if saturated=true) baroreceptor signal";
  parameter Real baro_broad_len = 3 "broadening length in seconds";
  parameter Real baro_broad_res = 100 "broadening calculation steps per second";
  parameter Real baro_broad_eta = 0.15 "broadening eta";
  parameter Real baro_broad_sigma = 0.11 "broadening sigma";
  
  parameter Real heart_T_refrac = 0.22 "refractory period that has to pass until a signal from the sinus node can take effect again";
  parameter Real heart_T_av = 1.7 "time that can pass after the beginning of a systole until the av node initiates a contraction";
  parameter Real heart_T_avc0 = 0.09 "base value for atrioventricular conduction time";
  parameter Real heart_tau_av = 0.11 "reference time for atrioventricular conduction time"; //TODO find better description
  parameter Real heart_k_av_t = 0.78 "sensitivity of the atrioventricular conduction time to the time passed since the last ventricular conduction";
  parameter Real heart_initial_T = heart_T_hat "initial value for T";
  parameter Real heart_initial_t_last = 0 "initial value for last ventricular contraction time";
  parameter Real heart_tau_sys = 0.125 "duration of systole";
  parameter Real heart_S_0 = 110 "base value for contractility";
  parameter Real heart_k_S_vNe = 110 "sensitivity of contractility to Norepinephrine concentration in the ventricles";
  parameter Real heart_k_S_mresp = 0 "sensitivity of contractility to mechanical pressure from respiration";
  parameter Real heart_T_hat = 1 "if RR-Interval is shorter than this time, contractility for the next beat decreases";
  parameter Real heart_compliance = 2 "arterial compliance in ml/mmHg";
  parameter Real heart_tau_wind0 = 1.3 "base value for windkessel relaxation";
  parameter Real heart_k_wind_rNe = 0.8 "sensitivity of windkessel relaxation to Norepinephrine in resistance vessels";
  parameter Real heart_p_wind0 = 7 "minimum blood pressure that remains even if the heart would completely stop";
equation
  connect(baro.artery,blood.vessel);
  connect(heart.artery,blood.vessel);
  connect(baro.signal,sym.baro);
  connect(baro.signal,para.baro);
  connect(lung.signal,sym.resp);
  connect(lung.signal,para.resp);
  connect(lung.resp,heart.mresp);
  connect(sym.signal,sNeEmit.excitation);
  connect(sym.signal,vNeEmit.excitation);
  connect(sym.signal,rNeEmit.excitation);
  connect(para.signal,sAcEmit.excitation);
  connect(para.signal,sNeEmit.inhibition);
  connect(para.signal,vNeEmit.inhibition);
  connect(para.signal,rNeEmit.inhibition);
  connect(sNeEmit.con,sNe.con);
  connect(vNeEmit.con,vNe.con);
  connect(rNeEmit.con,rNe.con);
  connect(sAcEmit.con,sAc.con);
  connect(sinus.sAc,sAc.con);
  connect(sinus.sNe,sNe.con);
  connect(heart.vNe,vNe.con);
  connect(heart.rNe,rNe.con);
  connect(heart.sinus,sinus.signal);
end SeidelThesisFullExample;