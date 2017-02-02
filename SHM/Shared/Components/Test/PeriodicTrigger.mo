within SHM.Shared.Components.Test;
model PeriodicTrigger
  SHM.Shared.Connectors.TriggerOutput outp;
  parameter Real T = 1;
  parameter Real start = 0;
equation
  outp.s = sample(start, T);
end PeriodicTrigger;
