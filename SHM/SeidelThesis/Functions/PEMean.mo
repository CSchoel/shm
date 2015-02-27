within SHM.SeidelThesis.Functions;
function PEMean "Mean of the PhaseEffectiveness function"
  input Integer resolution "how many calculation points to use";
  input Boolean minus = false "if true, the formula with a minus from Seidel's thesis is used";
  output Real mean "output value";
protected
  Real stepsize "step size of discretization";
  Real sum "sum of function values";
algorithm
  stepsize := 1/resolution;
  sum := 0;
  for i in 0:resolution loop
    sum := sum + SHM.SeidelThesis.Functions.PhaseEffectiveness(i/resolution,minus);
  end for;
  mean := sum / (resolution+1);
annotation(Documentation(info="<html>
  <p>Calculates the mean of the phase effectiveness function over the interval [0,1].</p>
</html>"));
end PEMean;