within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay;
model MultiConductionDelay
  extends UnidirectionalContractionComponent;
  // Note: We use a buffer of fixed size for incoming signals.
  // If a signal would overtake another signal, the overtaking
  // signal is considered to vanish.
  parameter Integer n = 100;
  discrete Real[n] buffer;
  Integer n_signals(start=0, fixed=true);
  Real duration;
protected
  Real t_next = time + duration;
  Real t_first = buffer[0];
  Real t_last = buffer[pre(n_signals)-1];
equation
  outp = time > t_first;
  when inp and (pre(n_signals) == 0 or t_next > t_last) then
    buffer[n_signals] = time + duration;
    n_signals = pre(n_signals) + 1;
    assert(n_signals <= n, "number of signals exceeds buffer length");
  end when;
  when outp then
    buffer[1:end-1] = pre(buffer[2:end]);
    buffer[n] = 0;
    n_signals = pre(n_signals) - 1;
  end when;
end MultiConductionDelay;
