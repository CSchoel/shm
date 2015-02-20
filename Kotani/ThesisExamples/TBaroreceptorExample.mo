within Kotani.ThesisExamples;
model TBaroreceptorExample
  Kotani.Components.Basic.RectRampBloodPressure rect(value=45,t1=1,t2=1.1,t3=3.6,t4=3.7);
  Kotani.Components.Basic.BloodSystem blood(initialPressure=80);
  Kotani.Components.TBaroreceptors baro(saturated=true);
equation
  connect(rect.vessel,blood.vessel);
  connect(blood.vessel,baro.artery);
end TBaroreceptorExample;