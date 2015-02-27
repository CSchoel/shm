within SHM.SeidelThesis.Components;
model Heart
  SHM.Shared.Connectors.RespirationInput mresp "mechanical respiratory influence";
  SHM.Shared.Connectors.SubstanceConcentration vNe "concentration of Norepinephrine in the ventricles";
  SHM.Shared.Connectors.SubstanceConcentration rNe "concentration of Norepinephrine in the resistance vessels";
  SHM.Shared.Connectors.DiscreteSignal sinus "sinus node signal";
  SHM.Shared.Connectors.BloodVessel artery "connection to blood system";
  Real tau_wind "windkessel relaxation (time until blood pressure hypothetically drops to zero during systole)";
  discrete Real S "Contractility";
  discrete Real T "duration of last heartbeat";
  discrete Real t_ventricle_next "time of next ventricular contraction";
  discrete Real t_ventricle_last "time of last ventricular contraction";
  parameter Real tau_sys = 0.125 "duration of systole";
  parameter Real t_refrac = 0.22 "refractory period that has to pass until a signal from the sinus node can take effect again";
  parameter Real tau_av = 1.7 "time that can pass after the beginning of a systole until the av node initiates a contraction";
  parameter Real t_av0 = 0.09 "base value for atrioventricular conduction time";
  parameter Real S_0 = 110 "base value for contractility";
  parameter Real k_S_vNe = 110 "sensitivity of contractility to Norepinephrine concentration in the ventricles";
  parameter Real k_S_mresp = 0 "sensitivity of contractility to mechanical pressure from respiration";
  parameter Real T_hat = 1 "if RR-Interval is shorter than this time, contractility for the next beat decreases";
  parameter Real k_av_t = 0.78 "sensitivity of the atrioventricular conduction time to the time passed since the last ventricular conduction";
  parameter Real compliance = 2 "arterial compliance in ml/mmHg";
  parameter Real tau_wind0 = 1.3 "base value for windkessel relaxation";
  parameter Real k_wind_rNe = 0.8 "sensitivity of windkessel relaxation to Norepinephrine in resistance vessels";
  parameter Real initial_T = T_hat "initial value for T_hat";
  parameter Real initial_t_ventricle = 0 "initial value for last ventricular contraction time";
  Real pdia "diastolic blood pressure";
  Real psys "systolic blood pressure";
  Boolean systole "if true, the system is currently in a systole";
  Real progress "progress of systole (rising from 0 to 1 linearly)";
initial equation
  T = initial_T;
  t_ventricle_next = tau_av;
  t_ventricle_last = initial_t_ventricle;
  pdia = artery.pressure;
  psys = artery.pressure;
equation
  progress = (time - t_ventricle_last) / tau_sys;
  //rsys is a manual differentiation of the following equation from the kotani model
  //psys = plast + S/compliance * progress * exp(1 - progress);
  der(psys) = 1 / tau_sys * S/compliance * (1 - progress) * exp(1 - progress);
  der(pdia) = -pdia / tau_wind;
  tau_wind = tau_wind0 + k_wind_rNe * rNe.concentration;
  
  when sinus.s >= 1 and time - t_ventricle_last > t_refrac then //sinus node fired after refractory period passed
    //this sinus signal only initiates the contraction, if the av-node doesn't do it beforehand
    t_ventricle_next = min(pre(t_ventricle_next),time + t_av0 + k_av_t * exp((time - pre(t_ventricle_last))/tau_av));
  elsewhen time > t_ventricle_next then
    t_ventricle_next = time + tau_av;
  end when;
  when time > t_ventricle_next then //actual ventricular contraction; begin of systole
    T = time - pre(t_ventricle_last);
    S = S_0 + (k_S_vNe * vNe.concentration + k_S_mresp * mresp.phase) * (1 - (1 - min(1,T/T_hat))^2);
    reinit(psys,pdia);
    t_ventricle_last = time;
  end when;
  when not systole then //end of systole
    reinit(pdia,psys);
  end when;
  
  systole = time > t_ventricle_next and time < t_ventricle_next + tau_sys;
  artery.pressure = if systole then psys else pdia;
  
  vNe.rate = 0;
  rNe.rate = 0;
end Heart;