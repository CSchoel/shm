within SHM.Shared.Components.Contraction;
partial model ConductionDelay
  Real delayTime(start=0, fixed=true);
  import SHM.Shared.Connectors.{TriggerInput, TriggerOutput};
  TriggerInput inp;
  TriggerOutput outp;
protected
  Real t_next(start=0, fixed=true);
  Boolean outb = time > t_next;
equation
  outp.s = edge(outb);
  when inp.s then
    t_next = time;
  end when;
end ConductionDelay;
