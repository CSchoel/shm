within Kotani.Components;
partial model SubstanceEmission "SubstanceEmission"
  Basic.Nerve trigger annotation(Placement(transformation(origin = {-4.9,90.1}, extent = {{-10,-10},{10,10}}), iconTransformation(origin = {-1.7,-48.3}, extent = {{-10,-10},{10,10}})));
  replaceable Basic.SubstanceConcentration con "SubstanceConcentration" annotation(Placement(transformation(origin = {-4.9,-9.9}, extent = {{-10,-10},{10,10}}), iconTransformation(origin = {-1.7,51.7}, extent = {{-10,-10},{10,10}})));
  parameter Real Tuptake = 2.0 "time for total uptake of substance";
  parameter Real prodFac = 1 "production factor";
  parameter Real triggerDelay = 0 "delay until release of substance is triggered";
protected
  Real signal;
equation
  con.rate = der(con.concentration);
  con.rate = -con.concentration / Tuptake + prodFac * signal;
  //we do not change input signals
  trigger.rate = 0;
  annotation(experiment(StopTime = 1, StartTime = 0));
end SubstanceEmission;

