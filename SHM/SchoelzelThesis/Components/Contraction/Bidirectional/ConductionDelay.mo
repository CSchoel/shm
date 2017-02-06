within SHM.SchoelzelThesis.Components.Contraction.Bidirectional;
/* Note: This model can only hold one signal on delay. If another signal occurs
   while one singal is still delayed, the second signal will be ignored. */
partial model ConductionDelay
  extends SHM.SchoelzelThesis.Components.Contraction.Bidirectional.BidirectionalContractionComponent;
  Real duration(start=0, fixed=true);
  type Direction = enumeration(Up, Down, None);
protected
  Real t_next(start=0, fixed=true);
  Direction direction_next(start=Direction.None, fixed=true);
  Boolean delay_passed = time > pre(t_next);
equation
  up.upward = edge(delay_passed) and pre(direction_next) == Direction.Up;
  down.downward = edge(delay_passed) and pre(direction_next) == Direction.Down;
  when up.downward and delay_passed then
    t_next = time + duration;
    direction_next = Direction.Down;
  elsewhen down.upward and delay_passed then
    t_next = time + duration;
    direction_next = Direction.Up;
  elsewhen up.downward
       and not delay_passed
       and pre(direction_next) == Direction.Up then
    direction_next = Direction.None;
  elsewhen down.upward
       and not delay_passed
       and pre(direction_next) == Direction.Down then
    direction_next = Direction.None;
  end when;
end ConductionDelay;
