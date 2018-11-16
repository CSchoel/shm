within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.OriginalSHM;
model RaceCondition
  extends UnidirectionalContractionComponent;
  input Real next_a;
  input Real next_b;
  Real next = min(next_a, next_b);
  Boolean next_passed = time > pre(next);
equation
  outp = edge(next_passed);
end RaceCondition;
