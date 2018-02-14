within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay;
partial model MultiCD
  "conduction delay strategy that allows multiple "
  +  "signals to be delayed at a time"
  extends ConductionDelay;
  parameter Integer n = 100
    "buffer size (max number of signals delayed at a time)";
  parameter Real min_dist = 0.22
    "minimal distance between two signals leaving the component";
  discrete Real[n] buffer(each fixed=true, each start=-1)
    "the buffer containing the scheduled emission times of delayed signals";
  Integer n_signals(start=0, fixed=true)
    "number of signals that are currently in the buffer";
protected
  Real t_emit = time + duration
    "time when the signal currently arriving should be emitted";
  Real t_next = pre(buffer[1])
    "time when the next signal should leave the component";
  Real t_last = if n_signals == 0 then -1 else pre(buffer[n_signals])
    "last signal that will leave the component";
  Boolean ignore = t_emit - t_last < min_dist
    "condition when an arriving signal should be ignored";
  Boolean delay_passed = time > t_next;
equation
  outp = edge(delay_passed);
algorithm
  when inp and not(ignore) then
    assert(pre(n_signals) < n, "signal buffer overflow, increase n!");
    // put the signal in the buffer
    buffer[1+pre(n_signals)] := t_emit;
    n_signals := pre(n_signals) + 1;
  end when;
  when outp then
    // remove the first signal by shifting all signals to the left
    // and filling the last entry with -1
    buffer[1:end-1] := buffer[2:end];
    buffer[end] := -1;
    n_signals := pre(n_signals) - 1;
    assert(n_signals >= 0, "more outputs than inputs?!?!");
  end when;
  annotation(Documentation(info="<html>
    <p>This model can be used as a conduction delay strategy in models that
    extend BaseCD, when multiple signals have to be delayed at a time.</p>
    <p>The implementation uses a buffer of fixed size for incoming signals.
    In the delay duration is variable, this also means that a slow signal
    may be followed by a faster signal that could potentially overtake the
    first. Since this model should represent a physiological conduction delay,
    this is not allowed and instead a signal will vanish if it would be
    closer than a given minimal distance to the previous signal after both
    have left the delay.</p>
    <p>In a variable duration implementation the duration of each signal
    will be determined at the time the signal arrives at the input. It
    is not possible to alter the delay of an already enqueued signal.</p>
  </html>"));
end MultiCD;
