within Kotani.Functions;
function Broaden "broadening function"
  input Real x;
  input Real eta = 0 "nu";
  input Real sigma = 1 "sigma";
  output Real xbroad;
algorithm
  xbroad := x;
end Broaden;