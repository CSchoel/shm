within SHM.Shared.Components.Contraction;
model Pacemaker
  import SHM.Shared.Connectors.{TriggerInput, TriggerOutput};
  TriggerInput external_stimulus;
  TriggerOutput signal;
  Real phase(start=0, fixed=true);
equation
  signal = external_stimulus or phase >= 1;
  when pre(signal) then
    reinit(phase, 0);
  end when;
end Pacemaker;
