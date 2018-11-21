within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.OriginalSHM;
model RaceCondition
  extends UnidirectionalContractionComponent;
  parameter Real initial_next = 1e100;
  discrete input Real next_a;
  discrete input Real next_b;
  Real next;
  discrete Real next_min = min(next_a, next_b);
  Boolean next_passed = time > pre(next);
initial equation
  next = initial_next;
equation
  outp = edge(next_passed);
algorithm
  when outp then
    next := initial_next;
  end when;
  when change(next_a) and change(next_b) and next_min < next then
    next := next_min;
  elsewhen change(next_a) and next_a < next then
    next := next_a;
  elsewhen change(next_b) and next_b < next then
    next := next_b;
  end when;
end RaceCondition;
