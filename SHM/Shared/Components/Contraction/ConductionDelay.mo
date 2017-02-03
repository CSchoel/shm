within SHM.Shared.Components.Contraction;
partial model ConductionDelay
  import SHM.Shared.Connectors.{TriggerInput, TriggerOutput};
  Real delay_time(start=0, fixed=true);
  TriggerInput inp;
  TriggerOutput outp;
protected
  Real t_next(start=0, fixed=true);
  Boolean outb = time > t_next;
equation
  outp = edge(outb);
  when inp then
    t_next = time + delay_time;
  end when;
end ConductionDelay;
