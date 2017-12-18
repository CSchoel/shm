within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
model Pacemaker
  extends UnidirectionalContractionComponent;
  Real phase(start=0, fixed=true);
equation
  outp = inp or phase >= 1;
  when pre(outp) then
    reinit(phase, 0);
  end when;
end Pacemaker;
