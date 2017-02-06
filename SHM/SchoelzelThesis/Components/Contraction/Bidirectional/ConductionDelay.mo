within SHM.SchoelzelThesis.Components.Contraction.Bidirectional;
partial model ConductionDelay
  extends SHM.SchoelzelThesis.Components.Contraction.Bidirectional.BidirectionalContractionComponent;
  Real delay_time(start=0, fixed=true);
  type Direction = enumeration(Up, Down, None);
protected
  Real t_next(start=0, fixed=true);
  Direction direction_next(start=Direction.None, fixed=true);
  Boolean delay_passed = time > t_next;
equation
  up_outgoing = edge(delay_passed) and direction_next == Direction.Up;
  down_outgoing = edge(delay_passed) and direction_next == Direction.Down;
  when up_incoming and delay_passed then
    t_next = time + delay_time;
    direction_next = Direction.Down;
  elsewhen down_incoming and delay_passed then
    t_next = time + delay_time;
    direction_next = Direction.Up;
  elsewhen up_incoming
       and not delay_passed
       and direction_next == Direction.Up then
    direction_next = Direction.None;
  elsewhen down_incoming
       and not delay_passed
       and direction_next == Direction.Down then
    direction_next = Direction.None;
  end when;
end ConductionDelay;
