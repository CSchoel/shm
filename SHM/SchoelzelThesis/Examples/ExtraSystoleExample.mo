within SHM.SchoelzelThesis.Examples;
model ExtraSystoleExample
  SHM.SchoelzelThesis.Components.Contraction.Unidirectional.Simplified.ExtraSystole.ModularContractionX con;
equation
  con.inp = sample(0, 0.8);
  con.extra = sample(0, 3);
end ExtraSystoleExample;
