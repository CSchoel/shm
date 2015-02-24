within SHM.Shared.Connectors;
connector NerveInput "Nerve input signal"
  input Real activation "nerve activation (firing frequency or percentage of firing neurons)";
  annotation(Icon(coordinateSystem(extent = {{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10,10}), graphics = {Rectangle(visible = true, origin = {1.0051,0.0}, rotation = 45, fillColor = {0,0,255}, fillPattern = FillPattern.Solid, extent = {{-70.0,-70.0},{70.0,70.0}})}));
annotation(Documentation(info="<html><p>Models a nerve input signal that can be interpreted as firing frequency or percentage of neurons firing in a larger nerve fiber.</p></html>"));
end NerveInput;

