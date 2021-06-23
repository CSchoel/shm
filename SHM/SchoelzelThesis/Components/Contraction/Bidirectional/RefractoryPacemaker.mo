within SHM.SchoelzelThesis.Components.Contraction.Bidirectional;
model RefractoryPacemaker
  extends SHM.SchoelzelThesis.Components.
          Contraction.Bidirectional.BidirectionalContractionComponent;
  import SHM.SchoelzelThesis.Components.Contraction.Bidirectional.{
    Pacemaker, RefractoryGate
  };
  replaceable Pacemaker pm;
  replaceable RefractoryGate gate;
equation
  up.downward = pm.up.downward;
  down.upward = pm.down.upward;
  pm.up.upward = gate.down.upward;
  pm.down.downward = gate.up.downward;
  gate.up.upward = up.upward;
  gate.down.downward = down.downward;
  pm.refractory = gate.refractory;
end RefractoryPacemaker;
