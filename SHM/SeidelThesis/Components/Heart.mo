within SHM.SeidelThesis.Components;
model Heart "Main heart model"
  SHM.Shared.Connectors.RespirationInput mresp "mechanical respiratory influence";
  SHM.Shared.Connectors.SubstanceConcentration vNe "concentration of Norepinephrine in the ventricles";
  SHM.Shared.Connectors.SubstanceConcentration rNe "concentration of Norepinephrine in the resistance vessels";
  SHM.Shared.Connectors.DiscreteSignal sinus "sinus node signal";
  SHM.Shared.Connectors.BloodVessel artery "connection to blood system";
  parameter Real T_refrac = 0.22 "refractory period that has to pass until a signal from the sinus node can take effect again";
  parameter Real T_av = 1.7 "time that can pass after the beginning of a systole until the av node initiates a contraction";
  parameter Real T_avc0 = 0.09 "base value for atrioventricular conduction time";
  parameter Real tau_av = 0.11 "reference time for atrioventricular conduction time"; //TODO find better description
  parameter Real k_av_t = 0.78 "sensitivity of the atrioventricular conduction time to the time passed since the last ventricular conduction";
  parameter Real initial_T = T_hat "initial value for T";
  parameter Real initial_t_last = 0 "initial value for last ventricular contraction time";
  SHM.SeidelThesis.Components.Contraction contraction(
  	T_refrac=T_refrac,T_av=T_av,initial_T=initial_T,initial_t_last=initial_t_last,
  	k_av_t=k_av_t,T_avc0=T_avc0,tau_av=tau_av
  ) "contraction model used to calculate the actual time of ventricular contraction";
  parameter Real tau_sys = 0.125 "duration of systole";
  parameter Real S_0 = 110 "base value for contractility";
  parameter Real k_S_vNe = 110 "sensitivity of contractility to Norepinephrine concentration in the ventricles";
  parameter Real k_S_mresp = 0 "sensitivity of contractility to mechanical pressure from respiration";
  parameter Real T_hat = 1 "if RR-Interval is shorter than this time, contractility for the next beat decreases";
  parameter Real compliance = 2 "arterial compliance in ml/mmHg";
  parameter Real tau_wind0 = 1.3 "base value for windkessel relaxation";
  parameter Real k_wind_rNe = 0.8 "sensitivity of windkessel relaxation to Norepinephrine in resistance vessels";
  Real tau_wind "windkessel relaxation (time until blood pressure hypothetically drops to zero during systole)";
  discrete Real S "Contractility";
  Real pdia "diastolic blood pressure";
  Real psys "systolic blood pressure";
  Boolean systole "if true, the system is currently in a systole";
  Real progress "progress of systole (rising from 0 to 1 linearly)";
initial equation
  psys = pdia "there is already a connection between one of these variables and artery.pressure";
equation
  contraction.signal = sinus.s >= 1;
  progress = (time - contraction.t_last) / tau_sys;
  //rsys is a manual differentiation of the following equation from the kotani model
  //psys = plast + S/compliance * progress * exp(1 - progress);
  der(psys) = 1 / tau_sys * S/compliance * (1 - progress) * exp(1 - progress);
  der(pdia) = -pdia / tau_wind;
  tau_wind = tau_wind0 + k_wind_rNe * rNe.concentration;
  systole = time - contraction.t_last < tau_sys;
  when systole then
    S = S_0 + (k_S_vNe * vNe.concentration + k_S_mresp * mresp.phase) * (1 - (1 - min(1,contraction.T/T_hat))^2);
    reinit(psys,pdia);
  end when;
  when not systole then //end of systole
    reinit(pdia,psys);
  end when;
  artery.pressure = if systole then psys else pdia;
  
  vNe.rate = 0;
  rNe.rate = 0;
annotation(Documentation(info="<html>
  <p>Models the heart itself including the function of the AV-Node and the Windkessel arteries.</p>
  <p>The heart switches between a formula for the systolic blood pressure rate and the diastolic blood pressure rate based on the following rules:</p>
  <ul>
    <li>When a contraction is triggered, switch to systole.
    <li>After <b>tau_sys</b> seconds switch back to diastole.
  </ul>
</html>"));
end Heart;
