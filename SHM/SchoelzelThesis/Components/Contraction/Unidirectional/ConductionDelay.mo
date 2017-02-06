within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
partial model ConductionDelay
  import SHM.Shared.Connectors.{ExcitationInput, ExcitationOutput};
  Real duration(start=0, fixed=true);
  ExcitationInput inp;
  ExcitationOutput outp;
protected
  Real t_next(start=0, fixed=true);
  Boolean outb = time > t_next;
equation
  outp = edge(outb);
  when inp then
    t_next = time + duration;
  end when;
end ConductionDelay;
