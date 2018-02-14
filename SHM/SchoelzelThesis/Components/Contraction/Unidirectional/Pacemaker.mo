within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
partial model Pacemaker
  "creates signals according to internal clock and lets external "
  + "signals pass"
  extends UnidirectionalContractionComponent;
  Real phase(start=0, fixed=true) "sum/integral of excitatory influences";
  SHM.Shared.Connectors.ExcitationInput reset "external signal that resets phase to zero";
equation
  outp = inp or phase >= 1;
  when reset then
    reinit(phase, 0);
  end when;
  annotation(Documentation(info="<html>
    <p>Acts as base model for all pacemaker models using an
    integrate-and-fire approach.</p>
    <p>This component will trigger an output when its phase variable reaches
    the value one. It will also let incoming signals pass through.</p>
    <p>The reset of the phase variable to zero can be triggered by an
    external input connector. This is required to couple the pacemaker
    with other components such as refractory gates.</p>
  </html>"));
end Pacemaker;
