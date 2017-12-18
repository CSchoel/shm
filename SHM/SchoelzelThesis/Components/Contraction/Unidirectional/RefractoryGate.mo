within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
partial model RefractoryGate
  "lets signals pass only when a given"
  +"refractory time has passed since the last signal"
  extends UnidirectionalContractionComponent;
  parameter Real t_first(start=0, fixed=true);
  Real T_refrac;
protected
  Real t_last(start=t_first);
equation
  outp = inp and time - pre(t_last) > T_refrac;
  when outp then
    t_last = time;
  end when;
end RefractoryGate;
