within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.OriginalSHM;
model DecoupledRefractoryGate
  "lets signals pass only when a given "
  + "refractory time has passed since the last reference signal"
  extends SHM.SchoelzelThesis.Components.Contraction.Unidirectional.UnidirectionalContractionComponent;
  import SHM.Shared.Connectors.{ExcitationInput, ExcitationOutput};
  ExcitationInput reference "reference signal";
  parameter Real t_first(start=0, fixed=true) "time stamp of last reference signal at the beginning of the simulation";
  parameter Real T_refrac(start=1, fixed=true) "refractory period";
  protected
  Real t_last(start=t_first);
  equation
  outp = inp and time - pre(t_last) > T_refrac;
  when reference then
    t_last = time;
  end when;
  annotation(Documentation(info="<html>
    <p>This component will let input signals pass only if the time since the
    last reference signal was received is greater than the refractory period.</p>
  </html>"));
end DecoupledRefractoryGate;