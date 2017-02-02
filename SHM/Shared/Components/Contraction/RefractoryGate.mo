within SHM.Shared.Components.Contraction;
partial model RefractoryGate
  "lets signals pass only when a given"
  +"refractory time has passed since the last signal"
  import SHM.Shared.Connectors.TriggerInput;
  import SHM.Shared.Connectors.TriggerOutput;
  parameter Real t_first(start=0, fixed=true);
  TriggerInput inp;
  TriggerOutput outp;
  Real T_refrac;
protected
  Real t_last(start=t_first);
equation
  outp.s = inp.s and time - pre(t_last) > T_refrac;
  when outp.s then
    t_last = time;
  end when;
end RefractoryGate;
