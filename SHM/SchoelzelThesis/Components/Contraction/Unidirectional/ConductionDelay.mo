within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
partial model ConductionDelay
  Real duration(start=0, fixed=true);
  extends UnidirectionalContractionComponent;
protected
  Real t_next(start=0, fixed=true);
  Boolean outb = time > t_next;
equation
  outp = edge(outb);
  when inp then
    t_next = time + duration;
  end when;
end ConductionDelay;
