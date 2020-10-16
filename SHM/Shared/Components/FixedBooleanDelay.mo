within SHM.Shared.Components;
model FixedBooleanDelay
  extends BooleanDelay;
  parameter Real delayTime = 0 "duration of the delay";
equation
  delayed = delay(continuousSignal, delayTime) > 0.5;
end FixedBooleanDelay;
