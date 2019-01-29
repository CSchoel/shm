within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.Simplified.ExtraSystole;
model RefractoryGateX
  extends UnidirectionalContractionComponent;
  parameter Real t_first(start=0, fixed=true) "time of first signal";
  Real T_refrac "refractory period";
protected
  Real t_last(start=t_first) "time of last output";
equation
  outp = inp and time - pre(t_last) > T_refrac;
  when outp then
    t_last = time;
  end when;
end RefractoryGateX;
