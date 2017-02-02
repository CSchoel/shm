within SHM.Shared.Components.Contraction;
model Pacemaker
  import SHM.Shared.Connectors.{TriggerInput, TriggerOutput};
  TriggerInput external_stimulus;
  TriggerOutput signal;
  Real phase(start=0, fixed=true);
equation
  signal.s = external_stimulus.s or phase >= 1;
  when pre(signal.s) then
    reinit(phase, 0);
  end when;
end Pacemaker;
