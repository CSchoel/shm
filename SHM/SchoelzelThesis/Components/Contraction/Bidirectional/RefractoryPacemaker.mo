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
  connect(up.downward, pm.up.downward);
  connect(down.upward, pm.down.upward);
  connect(pm.up.upward, gate.down.upward);
  connect(pm.down.downward, gate.up.downward);
  connect(gate.up.upward, up.upward);
  connect(gate.down.downward, down.downward);
  connect(pm.refractory, gate.refractory);
end RefractoryPacemaker;
