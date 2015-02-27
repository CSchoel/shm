within SHM.SeidelThesis.Components;
model SinusNode "Sinus node"
  parameter Real T_0 "heart period for denervated heart";
  parameter Real k_cNe "sensitivity of sinus node to concentration of Norepinephrine";
  parameter Real k_cAc "sensitivity of sinus node to concentration of Acetylcholine";
  Real phase;
  SHM.Shared.Connectors.SubstanceConcentration cNe;
  SHM.Shared.Connectors.SubstanceConcentration cAc;
  SHM.Shared.Connectors.DiscreteSignal signal;
protected
  parameter Real pemean = SHM.SeidelThesis.Functions.PEMean(100);
equation
  der(phase) = 1/T_0 (1 + k_cNe * cNe.concentration - k_cAc * cAc.concentration * SHM.SeidelThesis.Functions.PhaseEffectiveness(phase)/pemean);
end SinusNode;