within SHM.Shared.Components.Test;
model PeriodicTrigger
  SHM.Shared.Connectors.TriggerOutput outp;
  parameter Real T(start=1, fixed=true);
  parameter Real start(start=0, fixed=true);
equation
  outp.s = sample(start, T);
end PeriodicTrigger;
