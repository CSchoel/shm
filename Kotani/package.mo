package Kotani
  package Examples
    model BaroreceptorExample
      Kotani.Components.Baroreceptors baroreceptors1 annotation(Placement(visible=true, transformation(origin={-71.9822,26.8474}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
      Kotani.Components.Basic.BloodSystem bloodSystem1 annotation(Placement(visible=true, transformation(origin={-15.0,26.8873}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
      Kotani.Components.Basic.NerveSystem nerveSystem1 annotation(Placement(visible=true, transformation(origin={-80.0,75.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
      Kotani.Components.Basic.LinearBloodPressure linearBloodPressure1 annotation(Placement(visible=true, transformation(origin={-5.0,-25.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
    equation 
      connect(linearBloodPressure1.vessel,bloodSystem1.vessel) annotation(Line(visible=true, origin={-18.2,0.9549}, points={{13.2,-25.9549},{13.2,-12.9549},{-9.8,-12.9549},{-9.8,25.9324},{-6.8,25.9324}}));
      connect(baroreceptors1.signal,nerveSystem1.fiber) annotation(Line(visible=true, origin={-76.4911,58.9618}, points={{4.5089,-22.1144},{4.5089,3.0382},{-4.5089,3.0382},{-4.5089,16.0382}}));
      connect(baroreceptors1.artery,bloodSystem1.vessel) annotation(Line(visible=true, origin={-38.2456,26.8673}, points={{-33.7366,-0.0199},{10.2455,-0.0199},{10.2455,0.0199},{13.2455,0.0199}}));
      annotation(Diagram(coordinateSystem(extent={{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio=true, initialScale=0.1, grid={5,5})));
    end BaroreceptorExample;

    model SympatheticSystem
      Kotani.Components.Baroreceptors baroreceptors1 annotation(Placement(visible=true, transformation(origin={-68.1127,40.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
      Kotani.Components.Basic.BloodSystem bloodSystem1 annotation(Placement(visible=true, transformation(origin={-107.7574,1.9638}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
      Kotani.Components.Basic.LinearBloodPressure linearBloodPressure1(topval=200) annotation(Placement(visible=true, transformation(origin={-110.0,-30.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
      Kotani.Components.Basic.NerveSystem nerveSystem2 annotation(Placement(visible=true, transformation(origin={-45.0,65.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
      Kotani.Components.SimpleLung simpleLung1 annotation(Placement(visible=true, transformation(origin={0.0,72.3713}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
      Kotani.Components.Basic.RespiratorySystem respiratorySystem1 annotation(Placement(visible=true, transformation(origin={26.9455,50.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
    equation 
      connect(simpleLung1.resp,respiratorySystem1.phase) annotation(Line(visible=true, origin={1.6667,53.0278}, points={{-1.6667,9.56059},{-1.6667,-3.0278},{15.2788,-3.0278}}));
      connect(simpleLung1.baro,nerveSystem2.fiber) annotation(Line(visible=true, origin={-30.0,68.6857}, points={{20,3.6856},{-2,3.6856},{-2,-3.6857},{-16,-3.6857}}));
      connect(baroreceptors1.signal,nerveSystem2.fiber) annotation(Line(visible=true, origin={-60.7418,60.0}, points={{-7.3709,-10.0},{-7.3709,5.0},{14.7418,5.0}}));
      connect(bloodSystem1.vessel,baroreceptors1.artery) annotation(Line(visible=true, origin={-106.8462,20.9819}, points={{-10.9112,-19.0181},{-13.9112,-19.0181},{-13.9112,19.0181},{38.7335,19.0181}}));
      connect(linearBloodPressure1.vessel,bloodSystem1.vessel) annotation(Line(visible=true, origin={-115.8544,-12.0145}, points={{5.8544,-17.9855},{5.8544,-4.9855},{-4.9029,-4.9855},{-4.9029,13.9783},{-1.903,13.9783}}));
      annotation(Diagram(coordinateSystem(extent={{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio=true, initialScale=0.1, grid={5,5})));
    end SympatheticSystem;

    annotation(Diagram(coordinateSystem(extent={{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio=true, initialScale=0.1, grid={5,5})));
  end Examples;

  annotation(uses(Modelica(version="3.2")));
end Kotani;
