within SHM.Shared.Components.Contraction;
model ConductionDelayBD
  extends SHM.Shared.Components.Contraction.BidirectionalContractionComponent;
  Real delay_time(start=0, fixed=true);
  type Direction = enumeration(Left, Right, None);
protected
  Real t_next(start=0, fixed=true);
  Direction direction_next(start=Direction.None, fixed=true);
  Boolean delay_passed = time > t_next;
equation
  left.outgoing = edge(delay_passed) and direction_next == Direction.Left;
  right.outgoing = edge(delay_passed) and direction_next == Direction.Right;
  when left.incoming and delay_passed then
    t_next = time + delay_time;
    direction_next = Direction.Right;
  elsewhen right.incoming and delay_passed then
    t_next = time + delay_time;
    direction_next = Direction.Left;
  elsewhen left.incoming
       and not delay_passed
       and direction_next == Direction.Left then
    direction_next = Direction.None;
  elsewhen right.incoming
       and not delay_passed
       and direction_next == Direction.Right then
    direction_next = Direction.None;
  end when;
end ConductionDelayBD;
