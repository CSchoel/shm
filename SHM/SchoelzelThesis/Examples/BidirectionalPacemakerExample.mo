within SHM.SchoelzelThesis.Examples;
model BidirectionalPacemakerExample
  import SHM.SchoelzelThesis.Components.Contraction.Bidirectional.{
    ConstantPacemaker, ConstantRefractoryGate, ConstantConductionDelay,
    RefractoryPacemaker
  };
  import SHM.Shared.Components.Test.{
    ThreePhasesExcitation, DiracToSawtooth
  };
  parameter Real pacemaker_cycle = 0.9;
  parameter Real T_refrac = 0.4;
  RefractoryPacemaker pm(
    replaceable ConstantPacemaker pm(T=pacemaker_cycle),
    replaceable ConstantRefractoryGate gate(duration=T_refrac)
  );
  ThreePhasesExcitation ex(
    T_phase1 = 0.6 * T_refrac,
    T_phase2 = 1.1 * T_refrac,
    T_phase3 = 1.5 * pacemaker_cycle,
    phase_duration = 5
  );
  DiracToSawtooth up, down;
equation
  connect(ex.ex, pm.up_incoming);
  connect(up.dirac, pm.up_outgoing);
  connect(down.dirac, pm.down_outgoing);
  pm.down_incoming = false;
end BidirectionalPacemakerExample;
