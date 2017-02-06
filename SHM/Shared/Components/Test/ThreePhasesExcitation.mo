within SHM.Shared.Components.Test;
model ThreePhasesExcitation
  parameter Real T_phase1 = 0.5;
  parameter Real T_phase2 = 1;
  parameter Real T_phase3 = 2;
  parameter Real phase_duration = 5;
  SHM.Shared.Connectors.ExcitationOutput ex;
equation
  if time < phase_duration then
    ex = sample(0, T_phase1);
  elseif time < 2 * phase_duration then
    ex = sample(0, T_phase2);
  else
    ex = sample(0, T_phase3);
  end if;
end ThreePhasesExcitation;
