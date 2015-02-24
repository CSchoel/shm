within SHM.Kotani2005.Components;
model HormoneEmission "Emits hormones based on a neural signal"
  extends SubstanceEmission(triggerDelay = 4.2, prodFac = 0.5, Tuptake = 2);
  parameter Real baseSignal = 0.2 "base neural signal for triggering substance release";
  //trigger and con are manual redeclarations of the superclass components (needed to make annotations visible in OpenModelica)
  SHM.Shared.Connectors.NerveInput trigger "nerve signal that triggers substance release" annotation(Placement(visible = true, transformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SHM.Shared.Connectors.HormoneConcentration con "released substance concentration" annotation(Placement(visible = true, transformation(origin = {40, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {40, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  signal = delay(trigger.activation + baseSignal, triggerDelay, triggerDelay) annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Polygon(origin = {-63.0119, 47.0766}, fillColor = {255, 170, 127}, fillPattern = FillPattern.Solid, points = {{-19.8666, 37.9132}, {-21.0512, 33.767}, {-20.8538, 29.0286}, {-21.8409, 26.2646}, {-24.605, 22.3159}, {-22.2358, 15.4057}, {-25.5922, 10.4699}, {-27.5665, 5.53405}, {-27.9614, 2.17769}, {-23.223, -1.37611}, {-29.3434, -10.458}, {-25.3947, -15.5913}, {-24.0127, -20.922}, {-29.5408, -30.004}, {-14.141, -33.1629}, {-17.1025, -41.85}, {-1.11042, -45.2063}, {2.44338, -37.9013}, {7.77408, -41.2577}, {17.0534, -28.8194}, {11.673, -21.0964}, {19.5315, -12.0606}, {8.95868, -6.50938}, {19.2233, 1.93506}, {12.315, 9.08785}, {14.8817, 19.9467}, {3.82541, 20.3416}, {5.20744, 31.9901}, {-2.68989, 32.1876}, {-2.49246, 42.4541}, {-12.9564, 45.2182}, {-12.5616, 35.7414}, {-16.3128, 38.9003}, {-19.8666, 37.9132}}, smooth = Smooth.Bezier), Polygon(origin = {-30.8599, 50.1427}, fillColor = {170, 0, 0}, fillPattern = FillPattern.Solid, points = {{32.4487, -6.49947}, {21.9675, -4.96111}, {-1.99566, -0.352815}, {-18.8927, 7.02046}, {-26.8804, 17.1587}, {-31.1573, 18.7534}, {-34.8682, 20.5381}, {-36.7858, 19.4664}, {-33.9465, 17.6402}, {-28.4165, 15.9298}, {-24.4227, 10.3999}, {-29.9526, 10.7071}, {-32.1032, 12.5504}, {-36.097, 13.4721}, {-36.4043, 11.936}, {-33.0248, 11.3215}, {-31.4887, 9.78543}, {-33.0248, 7.94212}, {-37.3259, 5.17714}, {-37.0187, 4.25548}, {-34.5609, 5.48436}, {-30.2599, 9.17099}, {-26.266, 8.86378}, {-28.7238, 6.0988}, {-32.1032, 3.94826}, {-34.2537, 2.41216}, {-32.7176, 1.79772}, {-28.1093, 4.86992}, {-24.7299, 6.71324}, {-24.1155, 8.55656}, {-19.8144, 6.0988}, {-26.266, -2.81057}, {-29.9526, -6.18999}, {-36.7115, -5.88277}, {-38.862, -2.81057}, {-39.7837, -4.03945}, {-37.9404, -6.18999}, {-36.7115, -7.11165}, {-33.6393, -6.49721}, {-37.3259, -9.5694}, {-39.7837, -9.5694}, {-39.7837, -11.7199}, {-36.7115, -10.7983}, {-33.3321, -7.72609}, {-30.5671, -7.41887}, {-30.8743, -10.1838}, {-32.7176, -13.256}, {-35.1754, -15.4066}, {-37.9404, -16.3282}, {-37.0187, -17.2499}, {-33.3321, -16.021}, {-31.4887, -13.8705}, {-30.8743, -18.4788}, {-27.8021, -19.7077}, {-26.5732, -20.9365}, {-25.0371, -20.0149}, {-26.266, -19.0932}, {-28.4165, -17.8643}, {-30.2599, -15.0994}, {-29.9526, -12.6416}, {-29.6454, -10.7983}, {-28.7238, -8.34053}, {-25.0371, -4.34667}, {-26.266, -5.57555}, {-25.3444, -10.4911}, {-21.6577, -12.6416}, {-21.3505, -16.3282}, {-22.2722, -18.1716}, {-21.3505, -18.786}, {-19.8144, -16.021}, {-20.1216, -12.9488}, {-20.7361, -10.1838}, {-24.1155, -8.34053}, {-24.1155, -4.34667}, {-21.0433, 0.568844}, {-18.5855, 2.41216}, {-15.8205, 0.568844}, {-5.68229, -4.7785}, {2.91986, -8.03762}, {13.9798, -9.87662}, {30.8768, -14.7921}, {39.6562, -19.0789}, {44.967, -25.7607}, {49.2955, -36.7633}, {52.974, -51.8447}, {52.0038, -81.2215}, {43.7143, -103.157}, {51.4355, -120.037}, {93.0756, -119.188}, {95.4115, -87.9944}, {89.4395, -57.8696}, {71.8385, -35.5958}, {60.3228, -20.2456}, {44.763, -9.97069}, {32.4487, -6.49947}}, smooth = Smooth.Bezier), Ellipse(origin = {41.8793, -54.8602}, fillColor = {85, 0, 0}, fillPattern = FillPattern.Solid, extent = {{18.61, 9.55}, {-24.4879, -12.9788}}, endAngle = 360), Ellipse(origin = {25.7127, -59.39}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-3.43, 3.06}, {4.65353, -5.02353}}, endAngle = 360), Ellipse(origin = {37.8755, -54.5746}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-3.43, 3.06}, {4.65353, -5.02353}}, endAngle = 360), Ellipse(origin = {50.8559, -55.7992}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-3.43, 3.06}, {4.65353, -5.02353}}, endAngle = 360), Ellipse(origin = {51.2628, -77.6794}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-3.43, 3.06}, {4.65353, -5.02353}}, endAngle = 360), Ellipse(origin = {40.4866, -84.7819}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-3.43, 3.06}, {4.65353, -5.02353}}, endAngle = 360), Ellipse(origin = {25.7918, -76.9447}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-3.43, 3.06}, {4.65353, -5.02353}}, endAngle = 360), Ellipse(origin = {41.4663, -68.8625}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-3.43, 3.06}, {4.65353, -5.02353}}, endAngle = 360), Line(origin = {-10.04, -16.01}, points = {{-17.3857, 46.8681}, {7.84039, 39.2758}, {17.6369, 15.7641}, {14.4531, -14.6052}, {7.84039, -46.9338}}, thickness = 5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 8, smooth = Smooth.Bezier)}));
annotation(Documentation(info="<html>
  <p>Models emission of hormones as result of a neural signal.</p>
</html>"));
end HormoneEmission;