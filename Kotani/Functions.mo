within Kotani;
package Functions
  annotation(Diagram(coordinateSystem(extent={{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio=true, initialScale=0.1, grid={5,5})));
  function Sat
    input Real x;
    input Real sat;
    input Real satexp;
    output Real satx;
  algorithm 
    satx:=x + (sat - x)*x^satexp/(sat^satexp + x^satexp);
  end Sat;

end Functions;
