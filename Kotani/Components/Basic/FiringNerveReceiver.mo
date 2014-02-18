within Kotani.Components.Basic;
model FiringNerveReceiver
  Kotani.Components.Basic.Nerve nerve1 annotation(Placement(visible = true, transformation(origin = {-6.44007,99.1055}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-6.44007,99.1055}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  discrete Real test;
equation
  when pre(nerve1.activation) >= 0.5 then
      test = time;
  
  end when;
  annotation(Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Line(origin = {11.449,-5.72451}, points = {{-98.0322,-46.8694},{-37.5671,-46.8694},{-37.5671,2.86225},{23.9714,2.86225},{23.9714,49.0161},{63.6852,49.0161}})}));
end FiringNerveReceiver;

