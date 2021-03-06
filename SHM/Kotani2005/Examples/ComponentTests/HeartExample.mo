within SHM.Kotani2005.Examples.ComponentTests;
model HeartExample "heart model test"
  SHM.Shared.Components.Test.LinearNerveSignal linearNerveSignal1 "trigger signal for substances" annotation(Placement(visible = true, transformation(origin = {51.5116,-15.0089}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  SHM.Shared.Components.Test.DiracSignal diracsignal1 "sinus signal" annotation(Placement(visible = true, transformation(origin = {-11.0906,65.8041}, extent = {{-10.17,-5.17},{10.17,5.17}}, rotation = 0)));
  SHM.Kotani2005.Components.Heart heart1 "heart model in test" annotation(Placement(visible = true, transformation(origin = {-19.6303,-15.8965}, extent = {{33.2717,-33.2717},{-33.2717,33.2717}}, rotation = 0)));
  SHM.Kotani2005.Components.HormoneRelease HormoneRelease1 "cVne emission" annotation(Placement(visible = true, transformation(origin = {70.7424,64.6422}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  SHM.Kotani2005.Components.HormoneRelease HormoneRelease1 "cCne emission" annotation(Placement(visible = true, transformation(origin = {31.6964,54.4643}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  SHM.Shared.Components.Compartments.BloodSystem bloodSystem1(initialPressure = 50) "blood system" annotation(Placement(visible = true, transformation(origin = {36.2343,-48.4531}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  SHM.Shared.Components.Compartments.NeurotransmitterAmount neurotransmitteramount1 "cCne concentration" annotation(Placement(visible = true, transformation(origin = {76.7857,85.4911}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  SHM.Shared.Components.Compartments.HormoneAmount HormoneAmount1 "cVne concentration" annotation(Placement(visible = true, transformation(origin = {25,85.9375}, extent = {{-10,-10},{10,10}}, rotation = 0))); 
equation
  connect(neurotransmitteramount1.con,heart1.ccne) annotation(Line(points = {{76.9308,85.8371},{40.625,85.8371},{40.625,97.9911},{-46.4286,97.9911},{-46.4286,16.0714},{-46.4286,16.0714}}));
  connect(neurotransmitteramount1.con,HormoneRelease1.con) annotation(Line(points = {{76.9308,85.8371},{70.9821,85.8371},{70.9821,69.4196},{70.9821,69.4196}}));
  connect(HormoneAmount1.con,heart1.cvne) annotation(Line(points = {{25.1451,86.2835},{12.5,86.2835},{12.5,17.8571},{11.8304,17.8571},{11.8304,16.5179},{11.8304,16.5179}}));
  connect(HormoneRelease1.con,HormoneAmount1.con) annotation(Line(points = {{31.5264,59.6343},{24.3304,59.6343},{24.3304,80.3571},{24.3304,80.3571}}));
  connect(linearNerveSignal1.nerve1,HormoneRelease1.trigger) annotation(Line(points = {{49.3488,9.63327},{31.6964,9.63327},{31.6964,49.1071},{31.6964,49.1071}}));
  connect(bloodSystem1.vessel,heart1.artery) annotation(Line(points = {{26.2343,-48.4531},{14.7874,-48.4531},{14.7874,-15.5268},{14.7874,-15.5268}}));
  connect(heart1.sinusSignal,diracsignal1.signal) annotation(Line(points = {{-18.683,16.2959},{-1.47874,16.2959},{-1.47874,62.1072},{-1.36218,62.1072},{-1.36218,61.8668}}));
  connect(linearNerveSignal1.nerve1,HormoneRelease1.trigger) annotation(Line(points = {{49.3488,9.63327},{70.8408,9.63327},{70.8408,59.3918},{70.8408,59.3918}}));
  annotation(experiment(StartTime = 0, StopTime = 10, Tolerance = 0.000001));
annotation(Documentation(info="<html>
  <p>Models a simple system with synthetic hormone emissions and sinus signal to test the heart model.</p>
</html>"));
end HeartExample;
