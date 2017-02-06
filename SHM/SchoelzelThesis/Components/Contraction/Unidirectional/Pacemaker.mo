within SHM.SchoelzelThesis.Components.Contraction;
model Pacemaker
  import SHM.SchoelzelThesis.Connectors.{ExcitationInput, ExcitationOutput};
  ExcitationInput external_stimulus;
  ExcitationOutput signal;
  Real phase(start=0, fixed=true);
equation
  signal = external_stimulus or phase >= 1;
  when pre(signal) then
    reinit(phase, 0);
  end when;
end Pacemaker;
