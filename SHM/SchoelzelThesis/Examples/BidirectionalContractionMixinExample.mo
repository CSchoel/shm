within SHM.SchoelzelThesis.Examples;
model BidirectionalContractionMixinExample
  import SHM.SchoelzelThesis.Components.Contraction.BidirectionalMixin.{
    ConstantPacemakerMixin, ConstantRefractoryMixin, RefractoryPacemaker
  };
  import SHM.SchoelzelThesis.Components.Contraction.Bidirectional.{
    ConstantConductionDelay
  };
  import SHM.Shared.Components.Test.{
    ThreePhasesExcitation, DiracToSawtooth
  };
  parameter Real pacemaker_cycle = 0.9;
  parameter Real T_refrac = 0.4;
  parameter Real duration_constant = 0.2;
  RefractoryPacemaker pm(
    replaceable ConstantPacemakerMixin pace(T=pacemaker_cycle),
    replaceable ConstantRefractoryMixin refrac(duration=T_refrac)
  );
  ConstantConductionDelay cd(duration_constant=duration_constant);
  ThreePhasesExcitation ex(
    T_phase1 = 0.6 * T_refrac,
    T_phase2 = 1.1 * T_refrac,
    T_phase3 = 1.5 * pacemaker_cycle,
    phase_duration = 5
  );
  DiracToSawtooth up, down;
equation
  connect(ex.ex, pm.up_incoming);
  connect(pm.down_outgoing, cd.up_incoming);
  connect(pm.down_incoming, cd.up_outgoing);
  cd.down_incoming = false;
  connect(up.dirac, pm.up_outgoing);
  connect(down.dirac, cd.down_outgoing);
end BidirectionalContractionMixinExample;
