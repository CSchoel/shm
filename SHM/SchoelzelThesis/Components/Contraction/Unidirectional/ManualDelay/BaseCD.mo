within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay;
partial model BaseCD "base model that can use different conduction delay strategies"
  extends ConductionDelay;
  replaceable model Strategy = SingleCD constrainedby ConductionDelay
    "strategy to use for storing the delayed signals";
protected
  Strategy internalCD(inp=inp, outp=outp, duration=duration)
    "delegate all variables/connectors to internal conduction delay model";
  annotation(Documentation(info="<html>
    <p>This model delegates all variables and connectors to an internal
    replaceable conduction delay implementation.</p>
    <p>This is required to be able to choose the base model from which this
    component should inherit it's properties (either SingleCD or MultiCD).</p>
  </html>"));
end BaseCD;
