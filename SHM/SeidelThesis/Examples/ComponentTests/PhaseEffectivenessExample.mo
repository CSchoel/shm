within SHM.SeidelThesis.Examples.ComponentTests;
model PhaseEffectivenessExample
  Real x_minus;
  Real x_plus;
  parameter Real m_minus = SHM.SeidelThesis.Functions.PEMean(100,true);
  parameter Real m_plus = SHM.SeidelThesis.Functions.PEMean(100,false);
equation
  x_minus = SHM.SeidelThesis.Functions.PhaseEffectiveness(time,true);
  x_plus = SHM.SeidelThesis.Functions.PhaseEffectiveness(time,false);
end PhaseEffectivenessExample;