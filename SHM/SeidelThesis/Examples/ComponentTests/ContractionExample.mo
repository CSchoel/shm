within SHM.SeidelThesis.Examples.ComponentTests;
model ContractionExample "test model for contraction component"
  SHM.SeidelThesis.Components.Contraction cont "contraction model";
equation
  if time < 5 then
    cont.signal = sample(0,1);
  elseif time < 15 then
    cont.signal = sample(0,3);
  else
    cont.signal = sample(0,0.05);
  end if;
annotation(Documentation(info="<html>
  <p>Test model for contraction model that simulates a changing sinus frequency which is in the normal value range for 5 
  seconds, too slow for another 10 seconds and then too fast.</p>
  <p style=\"color:red;\">This model does not have graphical annotations. It is only designed for testing the component.</p>
</html>"));
  
end ContractionExample;