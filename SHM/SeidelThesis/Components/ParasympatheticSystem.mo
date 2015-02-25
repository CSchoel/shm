within SHM.SeidelThesis.Components;
class ParasympatheticSystem extends SHM.SeidelThesis.Components.ANSPart;
equation
  signal.activation = base_activity - baro_eq + resp_eq;
end ParasympatheticSystem;