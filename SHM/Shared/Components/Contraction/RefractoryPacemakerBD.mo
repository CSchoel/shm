within SHM.Shared.Components.Contraction;
partial model RefractoryPacemakerBD
  extends SHM.Shared.Components.Contraction.BidirectionalContractionComponent;
  import SHM.Shared.Components.Contraction.{
    PacemakerBD, RefractoryGateBD
  };
  replaceable PacemakerBD pm;
  replaceable RefractoryGateBD gate;
equation
  connect(up_incoming, pm.up_incoming);
  connect(down_incoming, pm.down_incoming);
  connect(pm.up_outgoing, gate.down_incoming);
  connect(pm.down_outgoing, gate.up_incoming);
  connect(gate.up_outgoing, up_outgoing);
  connect(gate.down_outgoing, down_outgoing);
  connect(pm.refractory, gate.refractory);
end RefractoryPacemakerBD;
