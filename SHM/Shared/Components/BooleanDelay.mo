within SHM.Shared.Components;
model BooleanDelay "delay function for a boolean variable"
  input Boolean signal;
  output Boolean delayed;
  parameter Real delayTime(start=0) "duration of the delay";
protected
  // Note: We need pre() here because otherwise the if-expression would not
  // generate events.
  Real continuousSignal = if pre(signal) then 1.0 else 0.0 "auxiliary variable";
equation
  delayed = delay(continuousSignal, delayTime) > 0.5;
end BooleanDelay;
