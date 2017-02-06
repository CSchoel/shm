within SHM.SchoelzelThesis.Components.Contraction.Bidirectional;
partial model RefractoryPacemaker
  extends SHM.SchoelzelThesis.Components.
          Contraction.Bidirectional.BidirectionalContractionComponent;
  import SHM.SchoelzelThesis.Components.Contraction.Bidirectional.{
    Pacemaker, RefractoryGate
  };
  replaceable Pacemaker pm;
  replaceable RefractoryGate gate;
equation
  connect(up_incoming, pm.up_incoming);
  connect(down_incoming, pm.down_incoming);
  connect(pm.up_outgoing, gate.down_incoming);
  connect(pm.down_outgoing, gate.up_incoming);
  connect(gate.up_outgoing, up_outgoing);
  connect(gate.down_outgoing, down_outgoing);
  connect(pm.refractory, gate.refractory);
end RefractoryPacemaker;
