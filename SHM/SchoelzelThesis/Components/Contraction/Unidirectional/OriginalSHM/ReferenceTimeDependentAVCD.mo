within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.OriginalSHM;
model ReferenceTimeDependentAVCD
  "conduction delay for AV node where duration depends on the time that "
  + "has passed since the last reference signal was emitted"
  extends SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay.BaseCD(
    redeclare model Strategy = MultiCD(min_dist=min_dist)
  );
  import SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay.{
    MultiCD
  };
  import SHM.Shared.Connectors.ExcitationInput;
  import SHM.Shared.Connectors.ScheduleOutput;
  ExcitationInput reference "reference signal";
  parameter Real min_dist = 0 "minimal distance between two signals";
  parameter Real k_avc_t = 0.78 "sensitivity of the atrioventricular conduction time to the time passed since the last ventricular conduction";
  parameter Real T_avc0 = 0.09 "base value for atrioventricular conduction time";
  parameter Real tau_avc = 0.11 "reference time for atrioventricular conduction time";
  parameter Real initial_T_avc = 0.15 "initial value for conduction delay";
  Real T(start=0, fixed=true);
  Real t_last(start=0, fixed=true);
  ScheduleOutput t_next "time for which next signal is scheduled (1e100 if there is no such signal)";
initial equation
  duration = initial_T_avc;
  t_next = if internalCD.t_next > 0 then internalCD.t_next else 1e100;
equation
  when change(internalCD.t_next) then
    t_next = if internalCD.t_next > 0 then internalCD.t_next else 1e100;
  end when;
  when inp then
    T = time - pre(t_last);
    duration = T_avc0 + k_avc_t * exp(-T/tau_avc);
  end when;
  when reference then
    t_last = time;
  end when;
  annotation(Documentation(info="<html>
    <p>Represents a conduction delay with variable duration.</p>
    <p>Each signal arriving at this component is assigned the current
    delay. Changes to the delay will only have effect on current and future
    signals, not on already delayed signals.</p>
    <p>As basis for the calculation of the delay duration this model keeps
    track of the time since a signal was last emitted.</p>
  </html>"));
end ReferenceTimeDependentAVCD;
