within SHM.SeidelThesis.Functions;
function GreensFunction "green's function for baroreceptor boradening"
  input Real t "input";
  input Real eta "eta parameter";
  input Real sigma "sigma parameter";
  output Real g "output";
algorithm
  if t <= 0 then
    g := 0;
  else
    g := 1/sigma * exp(SHM.SeidelThesis.Functions.LnChiSquare(t/sigma,1+0.5*eta/sigma)); //from c-Code; paper uses 2 + eta/sigma
  end if;
annotation(Documentation(info="<html>
  <p>Green's function for baroreceptor signal broadening.</p>
</html>"));
end GreensFunction;