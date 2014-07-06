within Kotani.Components.Basic;
model NeurotransmitterAmount
  parameter Real initialConcentration = 0 "Initial neurotransmitter concentration";
  Kotani.Components.Basic.NeurotransmitterConcentration con annotation(Placement(visible = true, transformation(origin = {-14.2857,19.1964}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {1.45089,3.45982}, extent = {{-95.4241,-95.4241},{95.4241,95.4241}}, rotation = 0)));
equation
  con.rate = der(con.concentration);
  annotation(Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Rectangle(origin = {2.12054,-0.78125}, extent = {{-92.5223,95.2009},{92.5223,-95.2009}})}));
initial equation
  con.concentration = initialConcentration;
end NeurotransmitterAmount;

