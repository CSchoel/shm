within Kotani.Components.Basic;
model NerveSystem
  parameter Real initialActivation = 0 "Initial nerve activation";
  Kotani.Components.Basic.Nerve fiber annotation(Placement(visible = true, transformation(origin = {-52.1829,22.5723}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {-10.0,0.0}, extent = {{-31.8945,-31.8945},{31.8945,31.8945}}, rotation = 0)));
equation
  fiber.rate = der(fiber.activation);
  annotation(Icon(coordinateSystem(extent = {{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10,10}), graphics = {Rectangle(visible = true, origin = {-66.0563,-0.0}, fillColor = {0,0,255}, fillPattern = FillPattern.Solid, extent = {{-36.0563,-10.0},{36.0563,10.0}}),Rectangle(visible = true, origin = {64.8437,-0.0}, fillColor = {0,0,255}, fillPattern = FillPattern.Solid, extent = {{-34.8437,-10.0},{34.8437,10.0}})}), Diagram(coordinateSystem(extent = {{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5,5})));
initial equation
  fiber.activation = initialActivation;
end NerveSystem;
