within SHM.Shared.Components;
model VariableBooleanDelay
  extends BooleanDelay;
  parameter Real delayMax = 1;
  input Real delayTime;
equation
  delayed = delay(continuousSignal, delayTime, delayMax) > 0.5;
end VariableBooleanDelay;
