within SHM.SchoelzelThesis.Examples;
model BidirectionalContraction
  import SHM.SchoelzelThesis.Components.Contraction.Bidirectional.{
    ConstantPacemaker, ConstantRefractoryGate, ConstantConductionDelay,
    RefractoryPacemaker
  };
  parameter Real pacemaker_cycle = 0.9;
  parameter Real T_refrac = 0.4;
  parameter Real delay_constant = 0.2;
  RefractoryPacemaker pm(
    replaceable ConstantPacemaker pm(T=pacemaker_cycle),
    replaceable ConstantRefractoryGate gate(duration=T_refrac)
  );
  ConstantConductionDelay cd(delay_constant=delay_constant);
  SHM.Shared.Components.Test.ThreePhasesExcitation ex(
    T_phase1 = 0.5 * T_refrac,
    T_phase2 = 1.1 * T_refrac,
    T_phase3 = 1.5 * pacemaker_cycle,
    phase_duration = 5
  );
equation
  connect(ex.ex, pm.up_incoming);
  connect(pm.down_outgoing, cd.up_incoming);
  connect(pm.down_incoming, cd.up_outgoing);
  cd.down_incoming = false;
end BidirectionalContraction;
