within SHM.Shared.Connectors;
connector SubstanceConcentration "SubstanceConcentration"
  Real concentration "concentration of the substance";
  flow Real rate "rate of concentration change";
annotation(Documentation(info="<html>
  <p>This connector models a substance concentration with a unitless concentration and a rate of concentration change. 
  It should be connected to a <b>SHM.Shared.Components.HormoneAmount</b> or <b>SHM.Shared.Components.NeurotransmitterAmount</b> so that the relationship <b>rate = der(pressure)</b> is established.
  </p>")
);
end SubstanceConcentration;

