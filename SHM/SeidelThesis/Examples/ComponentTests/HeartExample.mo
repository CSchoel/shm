within SHM.SeidelThesis.Examples.ComponentTests;
model HeartExample
  SHM.SeidelThesis.Components.SubstanceEmission vNeEmit(tau=4,k_ex=0.014,k_in=0.006,delay_ex=2,delay_in=0.4,with_inhibition=true) "vNe";
  SHM.SeidelThesis.Components.SubstanceEmission rNeEmit(tau=4,k_ex=0.014,k_in=0,delay_ex=3,delay_in=0.4,with_inhibition=true) "rNe";
  SHM.Shared.Components.Test.LinearNerveSignal sym(t1=1,t2=2,baseval=20,topval=100) "sympathetic signal";
  SHM.Shared.Components.Test.LinearNerveSignal para(t1=1.5,t2=2.5,baseval=10,topval=50) "parasympathetic signal";
  SHM.Shared.Components.Compartments.HormoneAmount vNe;
  SHM.Shared.Components.Compartments.HormoneAmount rNe;
  SHM.SeidelThesis.Components.Heart heart;
  SHM.SeidelThesis.Components.Lung lung;
  SHM.Shared.Components.Compartments.BloodSystem blood;
  SHM.Shared.Components.Test.DiracSignal sinus;
equation
  connect(heart.artery,blood.vessel);
  connect(sym.nerve1,vNeEmit.excitation);
  connect(sym.nerve1,rNeEmit.excitation);
  connect(para.nerve1,vNeEmit.inhibition);
  connect(para.nerve1,rNeEmit.inhibition);
  connect(lung.resp,heart.mresp);
  connect(heart.vNe,vNe.con);
  connect(heart.rNe,rNe.con);
  connect(heart.sinus,sinus.signal);
end HeartExample;