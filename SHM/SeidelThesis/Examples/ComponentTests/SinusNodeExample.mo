within SHM.SeidelThesis.Examples.ComponentTests;
model SinusNodeExample
  SHM.SeidelThesis.Components.SinusNode sinus;
  SHM.SeidelThesis.Components.SubstanceEmission cNeEmit(tau=2,k_ex=0.014,k_in=0.006,delay_ex=2,delay_in=0.4,with_inhibition=true) "cNe";
  SHM.SeidelThesis.Components.SubstanceEmission cAcEmit(tau=0.05,k_ex=0.005,delay_ex=0.4,with_inhibition=false) "cAc";
  SHM.Shared.Components.Test.LinearNerveSignal sym(t1=1,t2=2,baseval=20,topval=100) "sympathetic signal";
  SHM.Shared.Components.Test.LinearNerveSignal para(t1=1.5,t2=2.5,baseval=10,topval=50) "parasympathetic signal";
  SHM.Shared.Components.Compartments.NeurotransmitterAmount cNe;
  SHM.Shared.Components.Compartments.NeurotransmitterAmount cAc;
equation
  connect(cNeEmit.excitation,sym.nerve1);
  connect(cNeEmit.inhibition,para.nerve1);
  connect(cAcEmit.excitation,para.nerve1);
  connect(cNeEmit.con,cNe.con);
  connect(cAcEmit.con,cAc.con);
  connect(sinus.sNe,cNe.con);
  connect(sinus.sAc,cAc.con);
end SinusNodeExample;