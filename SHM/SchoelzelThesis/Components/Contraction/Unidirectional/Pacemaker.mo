within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
partial model Pacemaker
  extends UnidirectionalContractionComponent;
  Real phase(start=0, fixed=true);
  SHM.Shared.Connectors.ExcitationInput reset;
equation
  outp = inp or phase >= 1;
  when reset then
    reinit(phase, 0);
  end when;
end Pacemaker;
