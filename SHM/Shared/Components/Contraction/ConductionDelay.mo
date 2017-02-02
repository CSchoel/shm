within SHM.Shared.Components.Contraction;
partial model ConductionDelay
  import SHM.Shared.Connectors.{TriggerInput, TriggerOutput};
  Real delayTime(start=0, fixed=true);
  TriggerInput inp;
  TriggerOutput outp;
protected
  Real t_next(start=0, fixed=true);
  Boolean outb = time > t_next;
equation
  outp.s = edge(outb);
  when inp.s then
    t_next = time + delayTime;
  end when;
end ConductionDelay;
