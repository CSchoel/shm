within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.OriginalSHM;
model SchedulingPacemaker
  SHM.Shared.Connectors.ExcitationInput reset;
  output Real t_next(start=-1, fixed=true);
  parameter Real T(start=1, fixed=true);
equation
  when time > pre(t_next) or reset then
    t_next = time + T;
  end when;
end SchedulingPacemaker;
