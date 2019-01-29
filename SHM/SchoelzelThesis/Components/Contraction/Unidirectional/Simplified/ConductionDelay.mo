within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.Simplified;
partial model ConductionDelay
  extends UnidirectionalContractionComponent;
  Real duration;
  Real T(start=0, fixed=true);
  Real t_last(start=0, fixed=true);
  Real t_next(start=-1, fixed=true);
  Boolean delay_passed = time > t_next;
equation
  outp = edge(delay_passed);
  when inp then
    T = time - pre(t_last);
    t_next = time + duration;
    assert(time > pre(t_next), "still on hold!");
  end when;
  when outp then
    t_last = time;
  end when;
end ConductionDelay;
