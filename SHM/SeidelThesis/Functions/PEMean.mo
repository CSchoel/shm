within SHM.SeidelThesis.Functions;
function PEMean
  input Integer resolution;
  input Boolean minus = false;
  output Real mean;
protected
  Real values[resolution+1];
  Real stepsize;
  Real sum;
algorithm
  stepsize := 1/resolution;
  values := fill(0,resolution+1);
  sum := 0;
  for i in 0:resolution loop
    sum := sum + SHM.SeidelThesis.Functions.PhaseEffectiveness(i/resolution,minus);
  end for;
  mean := sum / (resolution+1);
end PEMean;