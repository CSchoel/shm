within SHM.SeidelThesis.Examples.ComponentTests;
model SubstanceReleaseExample
  SHM.SeidelThesis.Components.SubstanceRelease cNe(tau=4,k_ex=0.014,k_in=0.006,delay_ex=2,delay_in=0.4,with_inhibition=true) "Norepinephrine concentration with inhibition";
  SHM.SeidelThesis.Components.SubstanceRelease  cAc(tau=0.05,k_ex=0.005,delay_ex=0.4,with_inhibition=false) "Acetylcholine concentration without inhibition";
  SHM.Shared.Components.Test.LinearNerveSignal sym(t1=1,t2=2,baseval=20,topval=100) "sympathetic signal";
  SHM.Shared.Components.Test.LinearNerveSignal para(t1=1.5,t2=2.5,baseval=10,topval=50) "parasympathetic signal";
equation
  connect(cNe.excitation,sym.nerve1);
  connect(cNe.inhibition,para.nerve1);
  connect(cAc.excitation,para.nerve1);
annotation(Documentation(info="<html>
  <p>Test model for SubstanceRelase that uses LinearNerveSignals to replace the ANS.</p>
  <p style=\"color:red;\">This model does not have graphical annotations. It is only designed for testing the component.</p>
</html>"));
end SubstanceReleaseExample;