within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay;
model MultiConductionDelay
  extends UnidirectionalContractionComponent;
  // Note: We use a buffer of fixed size for incoming signals.
  // If a signal would overtake another signal, the overtaking
  // signal is considered to vanish.
  parameter Integer n = 100;
  discrete Real[n] buffer(fixed=true, start=-ones(n));
  Integer n_signals(start=0, fixed=true);
  Real duration;
protected
  Real t_next = time + duration;
  Real t_first = pre(buffer[1]);
  Real t_last = if n_signals == 0 then -1 else pre(buffer[n_signals]);
equation
  outp = time > t_first;
algorithm
  when inp and (pre(n_signals) == 0 or t_next > t_last) then
    assert(pre(n_signals) < n, "signal buffer overflow, increase n!");
    buffer[1+pre(n_signals)] := t_next;
    n_signals := pre(n_signals) + 1;
  end when;
  when outp then
    // shift all signals to the left, filling the last with -1
    buffer[1:end-1] := buffer[2:end];
    buffer[end] := -1;
    n_signals := pre(n_signals) - 1;
    assert(n_signals >= 0, "more outputs than inputs?!?!");
  end when;
end MultiConductionDelay;
