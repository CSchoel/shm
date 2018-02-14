within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
partial model RefractoryGate
  "lets signals pass only when a given "
  + "refractory time has passed since the last signal"
  extends UnidirectionalContractionComponent;
  parameter Real t_first(start=0, fixed=true) "time stamp of last signal at the beginning of the simulation";
  Real T_refrac "refractory period";
protected
  Real t_last(start=t_first);
equation
  outp = inp and time - pre(t_last) > T_refrac;
  when outp then
    t_last = time;
  end when;
  annotation(Documentation(info="<html>
    <p>Acts as base model for refractory components.</p>
    <p>This component will let signals pass only if the time since the
    last signal was received is greater than the refractory period.</p>
  </html>"));
end RefractoryGate;
