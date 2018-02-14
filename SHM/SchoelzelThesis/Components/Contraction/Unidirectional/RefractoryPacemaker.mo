within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
model RefractoryPacemaker "combination of a refractory and a pacemaker component"
  extends UnidirectionalContractionComponent;
  replaceable ConstantPacemaker pace constrainedby Pacemaker "the pacemaker component";
  replaceable ConstantRefractoryGate gate constrainedby RefractoryGate "the refractory component";
equation
  connect(inp, pace.inp);
  connect(pace.outp, gate.inp);
  connect(pace.reset, gate.outp);
  connect(outp, gate.outp);
  annotation(Documentation(info="<html>
    <p>This model combines a pacemaker component with a refractory component
    so that the pacemaker signal is filtered through the refractory gate, but
    it is also only reset when a signal passes the gate.</p>
    <p>This is the normal behavior that one would expect of a pacemaker node,
    but it requires a connection order that can seem unituitive at first
    glance. That was the reason to encapsulate this behavior in a separate
    model.</p>
  </html>"));
end RefractoryPacemaker;
