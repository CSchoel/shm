within SHM.Shared.Components.Test;

model StaticNerveSignal
  parameter Real activity = 0;
  SHM.Shared.Connectors.NerveOutput nerve annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  nerve.activation = activity;
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {1.30435, -2.6087}, extent = {{-100.87, 102.174}, {98.2609, -97.3913}}), Line(origin = {-0.654783, -2.60739}, points = {{-99.3478, 0}, {99.3478, 0}}, color = {0, 0, 255}, thickness = 1), Text(origin = {-4.57, 19.1348}, extent = {{-42.39, 10.87}, {42.39, -10.87}}, textString = "%activity")}));
end StaticNerveSignal;