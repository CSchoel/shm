within SHM.SeidelThesis.Components;
model NeurotransmitterRelease "SubstanceRelease that models hormones" extends SubstanceRelease;
annotation(Documentation(info="<html>
  <p>This model has the same functionality as <b>SHM.SeidelThesis.Components.SubstanceRelease</b>, but the icon displays the release of a neurotransmitter at a synapse.</p>
</html>"),  Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Polygon(origin = {-45.31, 1.4}, fillColor = {170, 255, 255}, fillPattern = FillPattern.Solid, points = {{-52.0237, 25.8547}, {-52.0237, -27.4523}, {-51.234, -27.4523}, {0.691017, -27.4523}, {1.67818, -27.4523}, {10.5627, -34.9548}, {21.8164, -50.1572}, {36.0316, -57.6596}, {49.0622, -56.7335}, {50.0494, -51.5632}, {49.9506, -36.5343}, {49.9013, -34.1651}, {38.2281, -40.088}, {24.7471, -30.9567}, {33.971, -17.6794}, {49.9076, -22.7633}, {50.0772, -20.9617}, {50.4582, -1.10733}, {50.4513, 1.71227}, {36.6239, -7.709}, {22.4087, 2.26136}, {33.2676, 20.9682}, {50.6417, 8.0116}, {50.6417, 10.023}, {50.8391, 21.8509}, {50.6417, 26.907}, {40.6578, 27.8241}, {39.6345, 40.808}, {46.4225, 43.1343}, {50.6787, 47.906}, {50.567, 52.6626}, {50.5111, 58.4397}, {50.813, 62.7857}, {31.8855, 57.6414}, {18.6575, 38.0955}, {2.86277, 25.8547}, {0.691013, 25.8546}, {-52.0237, 25.8547}}, smooth = Smooth.Bezier), Ellipse(origin = {0.888483, 39.1687}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-1.97, 1.88}, {1.97, -1.88}}, endAngle = 360), Ellipse(origin = {40.9285, 17.1405}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-1.97, 1.88}, {1.97, -1.88}}, endAngle = 360), Ellipse(origin = {35.5978, -3.59001}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-1.97, 1.88}, {1.97, -1.88}}, endAngle = 360), Ellipse(origin = {14.0776, -31.4281}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-1.97, 1.88}, {1.97, -1.88}}, endAngle = 360), Ellipse(origin = {20.3954, -25.9}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-1.97, 1.88}, {1.97, -1.88}}, endAngle = 360), Ellipse(origin = {11.7084, 4.89962}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-1.97, 1.88}, {1.97, -1.88}}, endAngle = 360), Ellipse(origin = {12.893, 29.5788}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-1.97, 1.88}, {1.97, -1.88}}, endAngle = 360), Ellipse(origin = {-5.86321, -32.8101}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-1.97, 1.88}, {1.97, -1.88}}, endAngle = 360), Ellipse(origin = {-0.729941, -26.0974}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-1.97, 1.88}, {1.97, -1.88}}, endAngle = 360), Ellipse(origin = {-12.9708, -28.2692}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-1.97, 1.88}, {1.97, -1.88}}, endAngle = 360), Ellipse(origin = {-8.03498, -23.9256}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-1.97, 1.88}, {1.97, -1.88}}, endAngle = 360), Ellipse(origin = {37.967, 35.6992}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-1.97, 1.88}, {1.97, -1.88}}, endAngle = 360), Ellipse(origin = {17.0391, 39.0556}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-1.97, 1.88}, {1.97, -1.88}}, endAngle = 360), Ellipse(origin = {-0.101615, 32.3429}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-1.97, 1.88}, {1.97, -1.88}}, endAngle = 360), Ellipse(origin = {-10.9965, 0.161224}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-1.97, 1.88}, {1.97, -1.88}}, endAngle = 360), Ellipse(origin = {-6.85038, 5.49192}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-1.97, 1.88}, {1.97, -1.88}}, endAngle = 360), Ellipse(origin = {-14.9451, 7.46626}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-1.97, 1.88}, {1.97, -1.88}}, endAngle = 360), Ellipse(origin = {-8.42984, 13.7841}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-1.97, 1.88}, {1.97, -1.88}}, endAngle = 360), Ellipse(origin = {58.9542, 34.9687}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-1.97, 1.88}, {1.97, -1.88}}, endAngle = 360), Ellipse(origin = {41.9749, -31.7638}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-1.97, 1.88}, {1.97, -1.88}}, endAngle = 360), Ellipse(origin = {65.4695, -28.6048}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-1.97, 1.88}, {1.97, -1.88}}, endAngle = 360), Ellipse(origin = {75.1437, 22.9253}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-1.97, 1.88}, {1.97, -1.88}}, endAngle = 360), Ellipse(origin = {52.2414, -13.5999}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-1.97, 1.88}, {1.97, -1.88}}, endAngle = 360), Ellipse(origin = {62.9028, 3.37939}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-1.97, 1.88}, {1.97, -1.88}}, endAngle = 360), Ellipse(origin = {71.4517, -16.6996}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-1.97, 1.88}, {1.97, -1.88}}, endAngle = 360), Ellipse(origin = {79.5465, 0.0822507}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-1.97, 1.88}, {1.97, -1.88}}, endAngle = 360), Ellipse(origin = {56.6442, 17.6538}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-1.97, 1.88}, {1.97, -1.88}}, endAngle = 360), Ellipse(origin = {80.5336, 33.2511}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-1.97, 1.88}, {1.97, -1.88}}, endAngle = 360), Line(origin = {-14.51, 72.85}, points = {{-67.8184, 0}, {67.8184, 0}}, thickness = 5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 10)}));
end NeurotransmitterRelease;