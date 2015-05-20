within SHM.SeidelThesis.Examples.ComponentTests;
model SinusNodeExample
  SHM.SeidelThesis.Components.SinusNode sinus "sinus node";
  SHM.SeidelThesis.Components.SubstanceRelease sNeEmit(tau=2,k_ex=0.014,k_in=0.006,delay_ex=2,delay_in=0.4,with_inhibition=true) "release of cNe";
  SHM.SeidelThesis.Components.SubstanceRelease sAcEmit(tau=0.05,k_ex=0.005,delay_ex=0.4,with_inhibition=false) "release of cAc";
  SHM.Shared.Components.Test.LinearNerveSignal sym(t1=1,t2=2,baseval=20,topval=100) "sympathetic signal";
  SHM.Shared.Components.Test.LinearNerveSignal para(t1=1.5,t2=2.5,baseval=10,topval=50) "parasympathetic signal";
  SHM.Shared.Components.Compartments.NeurotransmitterAmount sNe "concentration of Norepinephrine";
  SHM.Shared.Components.Compartments.NeurotransmitterAmount sAc "concentration of Acetylcholine";
equation
  connect(sNeEmit.excitation,sym.nerve1);
  connect(sNeEmit.inhibition,para.nerve1);
  connect(sAcEmit.excitation,para.nerve1);
  connect(sNeEmit.con,sNe.con);
  connect(sAcEmit.con,sAc.con);
  connect(sinus.sNe,sNe.con);
  connect(sinus.sAc,sAc.con);
annotation(Documentation(info="<html>
  <p>Test model for the sinus node that also models the release of Neurotransmitters but uses a LinearNerveSignal to replace the ANS.</p>
  <p style=\"color:red;\">This model does not have graphical annotations. It is only designed for testing the component.</p>
</html>"));
end SinusNodeExample;