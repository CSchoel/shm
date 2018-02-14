within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay;
model AVConductionDelay "conduction delay within the AV node"
  extends TimeDependentCD;
  parameter Real k_avc_t = 0.78 "sensitivity of the atrioventricular conduction time to the time passed since the last ventricular conduction";
  parameter Real T_avc0 = 0.09 "base value for atrioventricular conduction time";
  parameter Real tau_avc = 0.11 "reference time for atrioventricular conduction time";
  parameter Real initial_T_avc = 0.15 "initial value for conduction delay";
initial equation
  duration = initial_T_avc;
equation
  when inp then
    duration = T_avc0 + k_avc_t * exp(-T/tau_avc);
  end when;
  annotation(Documentation(info="<html>
    <p>Represents the conduction delay within the AV node
    (from the time when a signal arrives from the atrium to the time when a
    signal reaches the bundle of His).</p>
    <p>The duration depends on the time since the last signal has been
    emitted to the bundle of His and uses the formula given in the thesis of
    Dr. Seidel.</p>
  </html>"));
end AVConductionDelay;
