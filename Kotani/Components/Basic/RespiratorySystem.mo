within Kotani.Components.Basic;
model RespiratorySystem
  Kotani.Components.Basic.RespiratoryPhase phase annotation(Placement(visible=true, transformation(origin={-78.5812,1.3022}, extent={{-14.85,-10.5},{14.85,10.5}}, rotation=0), iconTransformation(origin={-100.0,-0.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
equation
  phase.rate=der(phase.phase);
  annotation(Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Ellipse(visible=true, fillColor={255,255,255},
            fillPattern =                                                                                                    FillPattern.Solid, extent={{-91.7546,-91.7546},{91.7546,91.7546}})}), Diagram(coordinateSystem(extent={{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio=true, initialScale=0.1, grid={5,5})));
end RespiratorySystem;
