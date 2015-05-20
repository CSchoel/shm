within SHM.SeidelThesis.Examples.ComponentTests;
model BaroreceptorExample
  SHM.Shared.Components.Test.RectRampBloodPressure rect(h=45,t1=1,t2=1.1,t3=3.6,t4=3.7) "input function for blood pressure";
  SHM.Shared.Components.Compartments.BloodSystem blood(initialPressure=80) "blood system";
  SHM.SeidelThesis.Components.Baroreceptors baro(saturated=true) "baroreceptor model";
equation
  connect(rect.vessel,blood.vessel);
  connect(blood.vessel,baro.artery);
annotation(Documentation(info="<html>
  <p>Test model for baroreceptors that shows the baroreceptor response to a recangular function of blood pressure.</p>
  <p style=\"color:red;\">This model does not have graphical annotations. It is only designed for testing the component.</p>
</html>"));
end BaroreceptorExample;