within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.OriginalSHM;
model SchedulingPacemaker
  SHM.Shared.Connectors.ExcitationInput reset;
  SHM.Shared.Connectors.ScheduleOutput t_next(start=T, fixed=true);
  parameter Real T = 1;
equation
  when reset then
    t_next = time + T;
  end when;
end SchedulingPacemaker;
