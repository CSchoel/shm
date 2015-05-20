within SHM.SeidelThesis.Examples.ComponentTests;
model ParaSympExample
  SHM.SeidelThesis.Components.SympatheticSystem sym(base_activity=50,k_baro_resp=0.4,k_resp=30) "sympathetic system";
  SHM.SeidelThesis.Components.ParasympatheticSystem para(base_activity=10,k_baro_resp=0.4,k_resp=30) "parasympathetic system";
  SHM.SeidelThesis.Components.Baroreceptors baro "baroreceptors";
  SHM.SeidelThesis.Components.Lung lung "the lung";
  SHM.Shared.Components.Compartments.BloodSystem blood "the blood system";
  SHM.Shared.Components.Test.RectRampBloodPressure psignal "the pressure signal";
equation
  connect(blood.vessel,psignal.vessel);
  connect(blood.vessel,baro.artery);
  connect(sym.resp,lung.signal);
  connect(sym.baro,baro.signal);
  connect(para.resp,lung.signal);
  connect(para.baro,baro.signal);
annotation(Documentation(info="<html>
  <p>Test model for sympathetic and parasympathetic system also modeling Baroreceptors and the lung but using a RectRampBloodPressure instead of the heart model.</p>
  <p style=\"color:red;\">This model does not have graphical annotations. It is only designed for testing the component.</p>
</html>"));
end ParaSympExample;