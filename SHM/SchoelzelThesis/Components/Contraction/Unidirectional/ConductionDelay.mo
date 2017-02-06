within SHM.SchoelzelThesis.Components.Contraction;
partial model ConductionDelay
  import SHM.SchoelzelThesis.Connectors.{ExcitationInput, ExcitationOutput};
  Real delay_time(start=0, fixed=true);
  ExcitationInput inp;
  ExcitationOutput outp;
protected
  Real t_next(start=0, fixed=true);
  Boolean outb = time > t_next;
equation
  outp = edge(outb);
  when inp then
    t_next = time + delay_time;
  end when;
end ConductionDelay;
