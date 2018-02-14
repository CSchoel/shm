within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
partial model UnidirectionalContractionComponent
  "basic contraction component with boolean input and output"
  import SHM.Shared.Connectors.{ExcitationInput, ExcitationOutput};
  ExcitationInput inp "input connector";
  ExcitationOutput outp "output connector";
  annotation(Documentation(info="<html>
    <p>Acts as base class for all unidirectional components that are part of a
    modular contraction model.</p>
    <p>The signals generated and received by these components should
    be seen as event indicators that can directly be used in a when
    equation. They should only be true for the exact time instant in
    which a contraction signal is received or produced.</p>
  </html>"));
end UnidirectionalContractionComponent;
