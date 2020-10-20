within SHM.BlesiusThesis.Examples;
model HeartPVCExample
  SHM.SeidelThesis.Components.SubstanceRelease vNeEmit(tau=4,k_ex=0.014,k_in=0.006,delay_ex=2,delay_in=0.4,with_inhibition=true) "vNe";
  SHM.SeidelThesis.Components.SubstanceRelease wNeEmit(tau=4,k_ex=0.014,k_in=0,delay_ex=3,delay_in=0.4,with_inhibition=true) "wNe";
  SHM.Shared.Components.Test.LinearNerveSignal sym(t1=1,t2=2,baseval=20,topval=100) "sympathetic signal";
  SHM.Shared.Components.Test.LinearNerveSignal para(t1=1.5,t2=2.5,baseval=10,topval=50) "parasympathetic signal";
  SHM.Shared.Components.Compartments.HormoneAmount vNe "ventricular concentration of Norepinephrine";
  SHM.Shared.Components.Compartments.HormoneAmount wNe "concentration of Norepinephrine in the Windkessel arteries";
  SHM.BlesiusThesis.Components.Heart heart "the heart";
  SHM.SeidelThesis.Components.Lung lung "the lung";
  SHM.Shared.Components.Compartments.BloodSystem blood "the blood system";
  SHM.Shared.Components.Test.DiracSignal sinus "the sinus node";
  
  Integer count_cont(start=0, fixed=true) "counts contractions";
  Boolean trigger = pre(count_cont) == 10 and time > pre(heart.contraction.cont_last) + pre(heart.contraction.d_interbeat)*0.7;
    
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
  
  heart.contraction.pvc = trigger; 
  when heart.contraction.outp then
    count_cont = pre(count_cont) + 1;
  end when;
annotation(Documentation(info="<html>
  <p>Test model for heart also modeling the lung and substance release but replacing the ANS with two LinearNerveSignal components
  and the sinus with a simple DiracSignal.</p>
  <p style=\"color:red;\">This model does not have graphical annotations. It is only designed for testing the component.</p>
</html>"));
end HeartPVCExample;