within SHM.SeidelThesis.Examples.ComponentTests;
model ParaSympExample
  SHM.SeidelThesis.Components.SympatheticSystem sym(base_activity=50,k_baro_resp=0.4,k_resp=30);
  SHM.SeidelThesis.Components.ParasympatheticSystem para(base_activity=10,k_baro_resp=0.4,k_resp=30);
  SHM.SeidelThesis.Components.Baroreceptors baro;
  SHM.SeidelThesis.Components.Lung lung;
  SHM.Shared.Components.Compartments.BloodSystem blood;
  SHM.Shared.Components.Test.RectRampBloodPressure psignal;
equation
  connect(blood.vessel,psignal.vessel);
  connect(blood.vessel,baro.artery);
  connect(sym.resp,lung.signal);
  connect(sym.baro,baro.signal);
  connect(para.resp,lung.signal);
  connect(para.baro,baro.signal);
end ParaSympExample;