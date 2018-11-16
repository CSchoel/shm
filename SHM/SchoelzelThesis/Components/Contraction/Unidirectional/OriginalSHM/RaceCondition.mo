within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.OriginalSHM;
model RaceCondition
  extends UnidirectionalContractionComponent;
  input Real next_a;
  input Real next_b;
  Real next_min = min(next_a, next_b);
  Real next;
  Boolean next_passed = time > pre(next);
initial equation
  next = next_min;
equation
  next = min(pre(next), next_min);
  when outp then
    reinit(next, next_min);
  end when;
  outp = edge(next_passed);
end RaceCondition;
