within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
model ModularContractionSHM "modular contraction model using unidirectional components"
  extends SHM.SchoelzelThesis.Components.Contraction.Unidirectional.UnidirectionalContractionComponent;
  import SHM.SchoelzelThesis.Components.Contraction.Unidirectional.OriginalSHM.{
    DecoupledRefractoryGate, RaceCondition, ReferenceTimeDependentAVCD,
    SchedulingPacemaker
  };
  import SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay.{
    MultiCD
  };
  // TODO find good value for pacemaker delay (should be 0.22 + average conduction delay)
  parameter Real T_refrac = 0.42 "refractory period";
  parameter Real T_av = 1.7 "time after which AV node generates a signal";
  ReferenceTimeDependentAVCD av_delay(
    redeclare model Strategy = MultiCD(min_dist=T_refrac)
  ) "internal delay of the AV node (from atria to His bundle)";
  SchedulingPacemaker pace "AV node pacemaker";
  RaceCondition race "race condition between AV and sinus signal";
  DecoupledRefractoryGate refrac(T_refrac=T_refrac) "refractory gate for sinus signal";
equation
  race.inp = false;
  connect(inp, refrac.inp);
  connect(refrac.outp, av_delay.inp);
  connect(pace.t_next, race.next_a);
  connect(av_delay.t_next, race.next_b);
  connect(outp, race.outp);
  connect(race.outp, pace.reset);
  connect(race.outp, av_delay.reference);
  connect(race.outp, refrac.reference);
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
