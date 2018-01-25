within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay;
model AVConductionDelay
  extends TimeDependentCD;
  parameter Real k_avc_t = 0.78 "sensitivity of the atrioventricular conduction time to the time passed since the last ventricular conduction";
  parameter Real T_avc0 = 0.09 "base value for atrioventricular conduction time";
  parameter Real tau_avc = 0.11 "reference time for atrioventricular conduction time";
  parameter Real initial_T_avc = 0.15;
initial equation
  duration = initial_T_avc;
equation
  when inp then
    duration = T_avc0 + k_avc_t * exp(-pre(T)/tau_avc);
  end when;
end AVConductionDelay;
