within SHM.Shared.Components;
partial model BooleanDelay "delay function for a boolean variable"
  input Boolean signal;
  output Boolean delayed;
protected
  // Note: We need pre() here because otherwise the if-expression would not
  // generate events.
  Real continuousSignal = if pre(signal) then 1.0 else 0.0 "auxiliary variable";
end BooleanDelay;
