within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
model Pacemaker
  import SHM.Shared.Connectors.{ExcitationInput, ExcitationOutput};
  ExcitationInput external_stimulus;
  ExcitationOutput signal;
  Real phase(start=0, fixed=true);
equation
  signal = external_stimulus or phase >= 1;
  when pre(signal) then
    reinit(phase, 0);
  end when;
end Pacemaker;
