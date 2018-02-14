within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay;
partial model ConductionDelay "interface for conduction delay components"
  extends UnidirectionalContractionComponent;
  Real duration "the duration of the delay";
  annotation(Documentation(info="<html>
    <p>Acts as base model/interface for conduction delay components.</p>
  </html>"));
end ConductionDelay;
