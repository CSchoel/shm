within SHM.Kotani2005.Components;
partial model SubstanceEmission "SubstanceEmission"
  SHM.Shared.Connectors.NerveInput trigger "nerve signal that triggers substance emission";
  replaceable SHM.Shared.Connectors.SubstanceConcentration con "concentration of emitted substance";
  parameter Real Tuptake = 2.0 "time for total uptake of substance";
  parameter Real prodFac = 1 "production factor";
  parameter Real triggerDelay = 0 "delay until release of substance is triggered";
protected
  Real signal "signal component that has to be specified by models that extend SubstanceEmission";
equation
  con.rate = con.concentration / Tuptake - prodFac * signal;
annotation(Documentation(info="<html>
  <p>Models the emission of a substance as a result of a nerve signal.</p>
  <p>Can be used for hormones as well as neurotransmitters.</p>
</html>"));
end SubstanceEmission;