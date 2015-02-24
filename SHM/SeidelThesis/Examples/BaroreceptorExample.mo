within SHM.SeidelThesis.Examples;
model BaroreceptorExample
  SHM.Shared.Components.Test.RectRampBloodPressure rect(value=45,t1=1,t2=1.1,t3=3.6,t4=3.7);
  SHM.Shared.Components.Compartments.BloodSystem blood(initialPressure=80);
  SHM.SeidelThesis.Components.Baroreceptors baro(saturated=true);
equation
  connect(rect.vessel,blood.vessel);
  connect(blood.vessel,baro.artery);
end BaroreceptorExample;