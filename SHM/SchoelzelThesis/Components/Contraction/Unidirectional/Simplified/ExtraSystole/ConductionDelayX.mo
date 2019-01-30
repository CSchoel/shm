within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.Simplified.ExtraSystole;
partial model ConductionDelayX
  extends UnidirectionalContractionComponent;
  Real duration;
  Real T(start=0, fixed=true);
  Real t_last(start=0, fixed=true);
  Real t_next(start=-1, fixed=true);
  Boolean delay_passed = time > t_next;
  input Boolean reset;
equation
  outp = edge(delay_passed);
  when reset or inp then
    T = time - pre(t_last);
  end when;
  when reset then
    t_next = 1e100;
  elsewhen inp then
    t_next = time + duration;
    assert(time > pre(t_next) or pre(t_next) > 1e99, "still on hold!");
  end when;
  when outp or reset then
    t_last = time;
  end when;
end ConductionDelayX;
