within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.Simplified;
model AVConductionDelay
  extends ConductionDelay;
  parameter Real k_avc_t = 0.78;
  parameter Real T_avc0 = 0.09;
  parameter Real tau_avc = 0.11;
  parameter Real initial_T_avc = 0.15;
initial equation
  duration = initial_T_avc;
equation
  when inp then
    duration = T_avc0 + k_avc_t * exp(-T/tau_avc);
  end when;
end AVConductionDelay;
