within SHM.Shared.Connectors;
connector TriggerOutput "discrete signal for pacemaker"
  output Boolean s "discrete signal (used for pacemaker signals)";
  annotation(Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Polygon(origin = {13.6868,0.2714}, fillColor = {0,255,255}, fillPattern = FillPattern.Solid, points = {{-113.502,99.9135},{-8.88093,37.4365},{85.0192,99.1741},{33.2632,-5.07731},{86.1284,-99.3472},{-9.98998,-46.8518},{-113.502,-100.456},{-50.6554,-2.8592},{-113.502,99.9135}})}));
annotation(Documentation(info="<html><p>Models a pacemaker signal as real valued discrete signal.</p></html>"));
end TriggerOutput;

