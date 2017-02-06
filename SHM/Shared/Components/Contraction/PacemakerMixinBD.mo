within SHM.Shared.Components.Contraction;
model PacemakerMixinBD
  Real phase(start=0, fixed=true);
  outer Boolean pacemaker_reset;
protected
  Boolean tick = phase >= 1;
equation
  when pacemaker_reset then
    reinit(phase, 0);
  end when;
end PacemakerMixinBD;
