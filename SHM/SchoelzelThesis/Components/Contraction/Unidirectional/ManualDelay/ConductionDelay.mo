within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay;
partial model ConductionDelay
  extends UnidirectionalContractionComponent;
  Real duration(start=0, fixed=true);
protected
  Real t_next(start=0, fixed=true);
  Boolean outb = time > t_next;
equation
  outp = edge(outb);
  when inp then
    t_next = time + duration;
  end when;
end ConductionDelay;
