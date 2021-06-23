within SHM.SchoelzelThesis.Components.Contraction.BidirectionalMixin;
model PacemakerMixin
  Real phase(start=0, fixed=true);
  outer Boolean pacemaker_reset;
  Boolean tick = phase >= 1;
equation
  when pacemaker_reset then
    reinit(phase, 0);
  end when;
end PacemakerMixin;
