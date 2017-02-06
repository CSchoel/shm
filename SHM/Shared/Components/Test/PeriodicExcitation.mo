within SHM.Shared.Components.Test;
model PeriodicExcitation
  SHM.Shared.Connectors.ExcitationOutput outp;
  parameter Real T = 1;
  parameter Real start = 0;
equation
  outp = sample(start, T);
end PeriodicExcitation;
