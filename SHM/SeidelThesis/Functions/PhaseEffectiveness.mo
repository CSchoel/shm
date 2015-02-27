within SHM.SeidelThesis.Functions;
function PhaseEffectiveness "phase effectiveness function"
  input Real phase "current phase value";
  input Boolean minus = false "allows to switch between the formula version with a minus (Seidel's thesis) and the version with a plus (Seidel's code)";
  output Real effectiveness "effectiveness of phase (between 0 and 1)";
algorithm
  if phase == 1 then
    effectiveness := 0;
  else
    effectiveness := (phase ^ 1.3) * (phase - 0.45) / ((0.2/(1-phase))^3 + (if minus then -1 else 1));
  end if;
annotation(Documentation(info="<html>
  <p>Calculates the effectiveness of vagal impulses on the sinus node, which is known to depend on the phase they occur in during the heart cycle.</p>
</html>"));
end PhaseEffectiveness;