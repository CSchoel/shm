within SHM.SchoelzelThesis.Examples;
model BidirectionalContractionExample
  import SHM.SchoelzelThesis.Components.Contraction.Bidirectional.{
    ConstantPacemaker, ConstantRefractoryGate, ConstantConductionDelay,
    RefractoryPacemaker
  };
  import SHM.Shared.Components.Test.{
    ThreePhasesExcitation, DiracToSawtooth
  };
  parameter Real pacemaker_cycle = 0.9;
  parameter Real T_refrac = 0.4;
  parameter Real duration_constant = 0.2;
  RefractoryPacemaker pm(
    replaceable ConstantPacemaker pm(T=pacemaker_cycle),
    replaceable ConstantRefractoryGate gate(duration=T_refrac)
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
  connect(ex.ex, pm.up.downward);
  connect(pm.down, cd.up);
  cd.down.upward = false;
  connect(up.dirac, pm.up.upward);
  connect(down.dirac, cd.down.downward);
end BidirectionalContractionExample;
