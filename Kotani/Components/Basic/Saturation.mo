within Kotani.Components.Basic;
model Saturation
  Real x;
  Real sat;
  Real satexp;
  Real satx;
equation
  satx = x + (sat - x) * x ^ satexp / (sat ^ satexp + x ^ satexp);
  annotation(Diagram(coordinateSystem(extent = {{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5,5})));
end Saturation;

