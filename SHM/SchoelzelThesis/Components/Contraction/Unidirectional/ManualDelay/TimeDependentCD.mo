within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay;
partial model TimeDependentCD
  "conduction delay where duration depends on the time that has passed "
  + "since the last signal was emitted"
  extends BaseCD;
  Real T(start=0, fixed=true);
  Real t_last(start=0, fixed=true);
  // TODO: add info to documentation why we not directly use time between signals?
equation
  when inp then
    T = time - pre(t_last);
  end when;
  when outp then
    t_last = time;
  end when;
  annotation(Documentation(info="<html>
    <p>Represents a conduction delay with variable duration.</p>
    <p>Each signal arriving at this component is assigned the current
    delay. Changes to the delay will only have effect on current and future
    signals, not on already delayed signals.</p>
    <p>As basis for the calculation of the delay duration this model keeps
    track of the time since a signal was last emitted.</p>
  </html>"));
end TimeDependentCD;
