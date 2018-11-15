within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
model ModularContractionSHM "modular contraction model using unidirectional components"
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
equation
  connect(inp, av.inp);
  connect(av.outp, av_delay.inp);
  connect(av_delay.outp, outp);
  annotation(Documentation(info="<html>
    <p>This model is a 1:1 modular replacement for
    SHM.SeidelThesis.Components.Contraction.</p>
    <p>It includes the variable time delay in the AV node, the refractory
    period of the AV node and the pacemaker functionality of the AV node.</p>
    <p>This model is created only to illustrate the behavior of the original
    SHM model. If you want to include this behavior in your model, consider
    using SHM.SeidelThesis.Components.Contraction or
    SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ModularContraction
    instead.</p>
  </html>"));
end ModularContractionSHM;
