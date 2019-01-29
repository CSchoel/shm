within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.Simplified;
partial model Pacemaker
  extends UnidirectionalContractionComponent;
  Real phase(start=0, fixed=true);
  input Boolean reset;
equation
  outp = inp or phase >= 1;
  when phase >= 1 or reset then
    reinit(phase, 0);
  end when;
end Pacemaker;
