within SHM.SeidelThesis.Functions;
function CreateGreenArray "array of green's function values"
  input Real len "length of the array in seconds";
  input Real resolution "resolution in steps/second";
  input Real eta "eta parameter for green's function";
  input Real sigma "sigma parameter for green's function"; 
  output Real[integer(ceil(len*resolution))] green "output";
protected
  Integer n "array size";
  Real stepsize "step size";
algorithm
  n := integer(ceil(resolution*len));
  stepsize := 1/resolution;
  green := fill(0,n);
  for i in 1:n loop
    green[i] := SHM.SeidelThesis.Functions.GreensFunction((i-1)*stepsize,eta,sigma);
  end for;
annotation(Documentation(info="<html>
  <p>Builds an array with green's function values for broadening with given length and parameters.</p>
</html>"));
end CreateGreenArray;