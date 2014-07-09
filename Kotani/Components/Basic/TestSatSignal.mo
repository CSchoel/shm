within Kotani.Components.Basic;
model TestSatSignal "Kotani.Functions.Sat(time, 2, 2);"
  Kotani.Components.Basic.NerveOutput no annotation(Placement(visible = true, transformation(origin = {148.5677,3.0386}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {100.0,2.8939}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
  Kotani.Components.Basic.Saturation sat;
equation
  sat.sat = 2;
  sat.satexp = 2;
  sat.x = time;
  //Kotani.Functions.Sat(time, 2, 2);
  no.activation = sat.satx;
  annotation(Diagram(coordinateSystem(extent = {{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5,5})));
end TestSatSignal;

