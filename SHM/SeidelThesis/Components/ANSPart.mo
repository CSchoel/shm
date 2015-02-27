within SHM.SeidelThesis.Components;
partial model ANSPart
  parameter Real base_activity = 0 "base activity of the nervous system";
  parameter Real k_baro_resp = 1 "sensitivity to correlated signal of baroreceptors and respiratory neurons";
  parameter Real k_resp = 1 "sensitivity to respiratory neurons";
  SHM.Shared.Connectors.NerveInput baro "input from the baroreceptors";
  SHM.Shared.Connectors.NerveInput resp "input from the respiratory neurons";
  SHM.Shared.Connectors.NerveOutput signal "output signal";
protected 
  Real baro_eq = (1 + k_baro_resp*resp.activation) * baro.activation "equation for baroreceptor influence";
  Real resp_eq = k_resp * resp.activation "equation for respiratory influence"; 
annotation(Documentation(info="<html>
  <p>Models a part of the autonomic nervous system (sympathicus or parasympathicus).</p>
  <p>The equation from Seidel is split into a respiratory part and a part that sums up baroreceptor influence and influence of correlated signal between baroreceptor and respiration.</p>
</html>"));
end ANSPart;