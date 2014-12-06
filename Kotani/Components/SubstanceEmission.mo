within Kotani.Components;

partial model SubstanceEmission "SubstanceEmission"
  Basic.NerveInput trigger;
  replaceable Basic.SubstanceConcentration con "SubstanceConcentration";
  parameter Real Tuptake = 2.0 "time for total uptake of substance";
  parameter Real prodFac = 1 "production factor";
  parameter Real triggerDelay = 0 "delay until release of substance is triggered";
protected
  Real signal;
equation
  con.rate = con.concentration / Tuptake - prodFac * signal;
end SubstanceEmission;