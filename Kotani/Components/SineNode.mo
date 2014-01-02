within Kotani.Components;

model SineNode
  parameter Real T0 = 0.6;
  parameter Real kphicne = 1.6;
  parameter Real chatcne = 2.0;
  parameter Real ncne = 2.0;
  parameter Real taucne = 2.0;
  parameter Real kccnes = 0.7;
  parameter Real phicne = 1.65;
  NerveSignal sympathicus;
  NerveSignal parasympathicus;
  NerveSignal phase;
protected
  Real fs "sympathetic influence on sinus node";
  Real ps "parasympathetic influence on sinus node";
  Real ccne "Cardiac Concentration of NorEpinephrine";
equation
  der(ccne) = delay(- ccne / taucne + kccnes * sympathicus.activation,phicne,phicne) ;
  fs = 1 + kphicne * (ccne + (chatcne - ccne) * ccne^ncne / (chatcne^ncne + ccne^ncne)) ;
  ps = 0;
  der(phase.activation) = phase.rate;
  phase.rate = 1/T0 * fs * ps;
end SineNode;