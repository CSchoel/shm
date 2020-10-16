within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay;
partial model SingleCD
  "conduction delay strategy that only allows one "
  +  "signal to be delayed at a time"
  extends ConductionDelay;
protected
  Real t_next(start=-1, fixed=true)
    "time when the next signal will leave the component";
  Boolean delay_passed(start=false, fixed=true) = time > t_next; // FIXME why does this need an initial value?
equation
  outp = edge(delay_passed);
  when inp then
    t_next = time + duration;
    assert(time > pre(t_next), "previous signal must have passed the" +
      "delay component before a new signal can be processed"
    );
  end when;
  annotation(Documentation(info="<html>
    <p>This model can be used as a conduction delay strategy in models that
    extend BaseCD, when only one signal will be delayed at a time.</p>
    <p>It uses the simplest possible implementation that just keeps track of
    the next time when a signal leaves the delay component. This is consistent
    with the implementation in SHM.SeidelThesis.Components.Contraction. This
    way it is only possible to have one signal delayed at a time. It will
    result in an error if a second signal arrives before the delay of the
    previous signal has passed.</p>
  </html>"));
end SingleCD;
