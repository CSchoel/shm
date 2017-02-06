within SHM.SchoelzelThesis.Components.Contraction.Bidirectional;
// TODO this should be an interface
model BidirectionalContractionComponent
  import SHM.Shared.Connectors.{
    BidirectionalExcitationInput,
    BidirectionalExcitationOutput
  };
  BidirectionalExcitationInput up;
  BidirectionalExcitationOutput down;
end BidirectionalContractionComponent;
