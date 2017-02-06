within SHM.Shared.Components.Contraction.Bidirectional;
// TODO this should be an interface
model BidirectionalContractionComponent
  import SHM.Shared.Connectors.{ExcitationInput, ExcitationOutput};
  ExcitationInput up_incoming;
  ExcitationOutput up_outgoing;
  ExcitationInput down_incoming;
  ExcitationOutput down_outgoing;
end BidirectionalContractionComponent;
