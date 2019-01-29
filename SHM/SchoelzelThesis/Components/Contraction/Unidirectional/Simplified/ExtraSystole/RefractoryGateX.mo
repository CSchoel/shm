within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.Simplified.ExtraSystole;
model RefractoryGateX
  extends UnidirectionalContractionComponent;
  parameter Real t_first = 0 "time of first signal";
  parameter Real T_refrac = 1 "refractory period";
  input Boolean reset;
protected
  Real t_last(start=t_first) "time of last output";
equation
  outp = inp and time - pre(t_last) > T_refrac;
  when outp or reset then
    t_last = time;
  end when;
end RefractoryGateX;
