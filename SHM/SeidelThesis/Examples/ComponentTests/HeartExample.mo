within SHM.SeidelThesis.Examples.ComponentTests;
model HeartExample
  SHM.SeidelThesis.Components.SubstanceRelease vNeEmit(tau=4,k_ex=0.014,k_in=0.006,delay_ex=2,delay_in=0.4,with_inhibition=true) "vNe";
  SHM.SeidelThesis.Components.SubstanceRelease wNeEmit(tau=4,k_ex=0.014,k_in=0,delay_ex=3,delay_in=0.4,with_inhibition=true) "wNe";
  SHM.Shared.Components.Test.LinearNerveSignal sym(t1=1,t2=2,baseval=20,topval=100) "sympathetic signal";
  SHM.Shared.Components.Test.LinearNerveSignal para(t1=1.5,t2=2.5,baseval=10,topval=50) "parasympathetic signal";
  SHM.Shared.Components.Compartments.HormoneAmount vNe;
  SHM.Shared.Components.Compartments.HormoneAmount wNe;
  SHM.SeidelThesis.Components.Heart heart;
  SHM.SeidelThesis.Components.Lung lung;
  SHM.Shared.Components.Compartments.BloodSystem blood;
  SHM.Shared.Components.Test.DiracSignal sinus;
equation
  connect(heart.artery,blood.vessel);
  connect(sym.nerve1,vNeEmit.excitation);
  connect(sym.nerve1,wNeEmit.excitation);
  connect(para.nerve1,vNeEmit.inhibition);
  connect(para.nerve1,wNeEmit.inhibition);
  connect(lung.resp,heart.mresp);
  connect(heart.vNe,vNe.con);
  connect(heart.wNe,wNe.con);
  connect(heart.sinus,sinus.signal);
end HeartExample;