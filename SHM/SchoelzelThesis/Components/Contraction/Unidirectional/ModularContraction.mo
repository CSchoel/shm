within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
model ModularContraction "modular contraction model using unidirectional components"
  extends SHM.SchoelzelThesis.Components.Contraction.Unidirectional.UnidirectionalContractionComponent;
  import SHM.SchoelzelThesis.Components.Contraction.Unidirectional.{
    ConstantPacemaker, ConstantRefractoryGate
  };
  import SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay.{
    AVConductionDelay, MultiCD
  };
  // TODO find good value for pacemaker delay (should be 0.22 + average conduction delay)
  parameter Real T_refrac = 0.42 "refractory period";
  parameter Real T_av = 1.7 "time after which AV node generates a signal";
  AVConductionDelay av_delay(
    redeclare model Strategy = MultiCD(min_dist=T_refrac)
  ) "internal delay of the AV node (from atria to His bundle)";
  RefractoryPacemaker av(gate.duration=T_refrac, pace.T=T_av) "AV node";
  discrete Real T(start=initial_T, fixed=true) "duration of last heart cycle";
  discrete Real cont_last(start=initial_cont_last, fixed=true) "time of last contraction";
  parameter Real initial_T = 1 "initial value for duration of last heart cycle";
  parameter Real initial_cont_last = 0 "initial value for time of last contraction";
equation
  connect(inp, av.inp);
  connect(av.outp, av_delay.inp);
  connect(av_delay.outp, outp);
  when outp then
    T = time - pre(cont_last);
    cont_last = time;
  end when;
  annotation(Documentation(info="<html>
    <p>This model essentially describes the signal conduction pathway from
    the AV node to the ventricles.</p>
    <p>It includes the variable time delay in the AV node, the refractory
    period of the AV node and the pacemaker functionality of the AV node.</p>
    <p>It can be seen as a modular replacement for
    SHM.SeidelThesis.Components.Contraction.</p>
  </html>"));
end ModularContraction;
