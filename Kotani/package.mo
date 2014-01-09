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

    model RespirationExample
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
      annotation(Diagram(coordinateSystem(extent={{-148.5,-105},{148.5,105}}, preserveAspectRatio=false, initialScale=0.1, grid={5,5}), graphics));
    end RespirationExample;

    annotation(Diagram(coordinateSystem(extent={{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio=true, initialScale=0.1, grid={5,5})));
    model SympatheticExample
      Components.Basic.LinearBloodPressure linearBloodPressure annotation(Placement(transformation(extent={{-78,-18},{-58,2}})));
      Components.Basic.BloodSystem bloodSystem annotation(Placement(transformation(extent={{-78,14},{-58,34}})));
      Components.Baroreceptors baroreceptors annotation(Placement(transformation(extent={{-70,54},{-50,74}})));
      Components.SimpleLung simpleLung annotation(Placement(transformation(extent={{-10,66},{10,86}})));
      Components.Basic.RespiratorySystem respiratorySystem annotation(Placement(transformation(extent={{30,44},{50,64}})));
      Components.SympatheticSystem sympatheticSystem annotation(Placement(transformation(extent={{0,8},{20,28}})));
      Components.Basic.NerveSystem nerveSystem annotation(Placement(transformation(extent={{-44,64},{-24,84}})));
      Components.Basic.NerveSystem nerveSystem1 annotation(Placement(transformation(extent={{6,-26},{26,-6}})));
    equation 
      connect(bloodSystem.vessel,linearBloodPressure.vessel) annotation(Line(points={{-78,24},{-78,-8},{-68,-8}}, color={0,0,0}, smooth=Smooth.None));
      connect(bloodSystem.vessel,baroreceptors.artery) annotation(Line(points={{-78,24},{-84,24},{-84,64},{-60,64}}, color={0,0,0}, smooth=Smooth.None));
      connect(simpleLung.resp,respiratorySystem.phase) annotation(Line(points={{0,66.2171},{16,66.2171},{16,54},{30,54}}, color={0,0,0}, smooth=Smooth.None));
      connect(simpleLung.resp,sympatheticSystem.resp) annotation(Line(points={{0,66.2171},{6,66.2171},{6,28},{10,28}}, color={0,0,0}, smooth=Smooth.None));
      connect(nerveSystem.fiber,baroreceptors.signal) annotation(Line(points={{-35,74},{-60,74}}, color={0,0,0}, smooth=Smooth.None));
      connect(nerveSystem.fiber,simpleLung.baro) annotation(Line(points={{-35,74},{-22,74},{-22,76},{-10,76}}, color={0,0,0}, smooth=Smooth.None));
      connect(nerveSystem.fiber,sympatheticSystem.baro) annotation(Line(points={{-35,74},{-18,74},{-18,18},{0,18}}, color={0,0,0}, smooth=Smooth.None));
      connect(nerveSystem1.fiber,sympatheticSystem.signal) annotation(Line(points={{15,-16},{12,-16},{12,8},{10,8}}, color={0,0,0}, smooth=Smooth.None));
      annotation(Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
    end SympatheticExample;

    model ParaSympatheticExample
      Kotani.Components.Basic.LinearBloodPressure linearBloodPressure annotation(Placement(transformation(extent={{-78,-18},{-58,2}})));
      Kotani.Components.Basic.BloodSystem bloodSystem annotation(Placement(transformation(extent={{-78,14},{-58,34}})));
      Kotani.Components.Baroreceptors baroreceptors annotation(Placement(transformation(extent={{-70,54},{-50,74}})));
      Kotani.Components.SimpleLung simpleLung annotation(Placement(transformation(extent={{-10,66},{10,86}})));
      Kotani.Components.Basic.RespiratorySystem respiratorySystem annotation(Placement(transformation(extent={{30,44},{50,64}})));
      Kotani.Components.Basic.NerveSystem nerveSystem annotation(Placement(transformation(extent={{-44,64},{-24,84}})));
      Kotani.Components.Basic.NerveSystem nerveSystem1 annotation(Placement(transformation(extent={{6,-26},{26,-6}})));
      Kotani.Components.ParasympatheticSystem parasympatheticSystem1 annotation(Placement(visible=true, transformation(origin={3.3073,20.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
    equation 
      connect(parasympatheticSystem1.resp,respiratorySystem.phase) annotation(Line(visible=true, origin={12.2049,46.0}, points={{-8.8976,-16.0},{-8.8976,8.0},{17.7951,8.0}}));
      connect(parasympatheticSystem1.signal,nerveSystem1.fiber) annotation(Line(visible=true, origin={9.1536,-3.0}, points={{-5.8463,13.0},{-5.8463,0.0},{5.8464,0.0},{5.8464,-13.0}}));
      connect(nerveSystem.fiber,parasympatheticSystem1.baro) annotation(Line(visible=true, origin={-25.5642,38.0}, points={{-9.4358,36.0},{-9.4358,-18.0},{18.8715,-18.0}}));
      connect(bloodSystem.vessel,linearBloodPressure.vessel) annotation(Line(points={{-78,24},{-78,-8},{-68,-8}}, color={0,0,0}, smooth=Smooth.None));
      connect(bloodSystem.vessel,baroreceptors.artery) annotation(Line(points={{-78,24},{-84,24},{-84,64},{-60,64}}, color={0,0,0}, smooth=Smooth.None));
      connect(simpleLung.resp,respiratorySystem.phase) annotation(Line(points={{0,66.2171},{16,66.2171},{16,54},{30,54}}, color={0,0,0}, smooth=Smooth.None));
      connect(nerveSystem.fiber,baroreceptors.signal) annotation(Line(points={{-35,74},{-60,74}}, color={0,0,0}, smooth=Smooth.None));
      connect(nerveSystem.fiber,simpleLung.baro) annotation(Line(points={{-35,74},{-22,74},{-22,76},{-10,76}}, color={0,0,0}, smooth=Smooth.None));
      annotation(Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
    end ParaSympatheticExample;

    model SatSignalExample
      annotation(Diagram(coordinateSystem(extent={{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio=true, initialScale=0.1, grid={5,5})));
      Real r;
      Kotani.Components.Basic.TestSatSignal testSatSignal1 annotation(Placement(visible=true, transformation(origin={-80.0,20.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
      Kotani.Components.Basic.NerveSystem nerveSystem1 annotation(Placement(visible=true, transformation(origin={-35.0,20.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
    equation 
      connect(testSatSignal1.no,nerveSystem1.fiber) annotation(Line(visible=true, origin={-50.6119,20.1447}, points={{-19.3881,0.1447},{2.3881,0.1447},{2.3881,-0.1447},{14.6119,-0.1447}}));
      r=Kotani.Functions.Sat(time, 2, 2);
    end SatSignalExample;

    model SinusExample
      annotation(Diagram(coordinateSystem(extent={{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio=true, initialScale=0.1, grid={5,5})));
      Kotani.Components.Basic.NerveSystem nerveSystem1 annotation(Placement(visible=true, transformation(origin={-60.0,60.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
      Kotani.Components.Basic.LinearNerveSignal linearNerveSignal1(topval=10) annotation(Placement(visible=true, transformation(origin={-110.0,65.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
      Kotani.Components.Basic.NerveSystem nerveSystem2 annotation(Placement(visible=true, transformation(origin={15.0,50.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
      Kotani.Components.Basic.NerveSystem nerveSystem3 annotation(Placement(visible=true, transformation(origin={-20.0,-20.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
      Kotani.Components.SinusNode sinusNode1 annotation(Placement(visible=true, transformation(origin={-15.0,17.8768}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
      Kotani.Components.Basic.LinearNerveSignal linearNerveSignal2(t1=3, t2=4, topval=0.1) annotation(Placement(visible=true, transformation(origin={30.0,77.0404}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
    equation 
      connect(linearNerveSignal2.nerve1,nerveSystem2.fiber) annotation(Line(visible=true, origin={22.0,63.2601}, points={{8.0,13.7803},{8.0,-0.2601},{-8.0,-0.2601},{-8.0,-13.2601}}));
      connect(nerveSystem2.fiber,sinusNode1.parasympathicus) annotation(Line(visible=true, origin={2.3525,33.8212}, points={{11.6475,16.1788},{11.6475,-2.9444},{-11.6475,-2.9444},{-11.6475,-10.2899}}));
      connect(nerveSystem1.fiber,sinusNode1.sympathicus) annotation(Line(visible=true, origin={-34.3757,41.7887}, points={{-26.6243,18.2113},{6.3757,18.2113},{6.3757,-18.2113},{13.8728,-18.2113}}));
      connect(sinusNode1.phase,nerveSystem3.fiber) annotation(Line(visible=true, origin={-18.0,-6.0308}, points={{3.0,15.9076},{3.0,-0.9692},{-3.0,-0.9692},{-3.0,-13.9692}}));
      connect(linearNerveSignal1.nerve1,nerveSystem1.fiber) annotation(Line(visible=true, origin={-79.3619,62.5}, points={{-30.6381,2.5},{6.1381,2.5},{6.1381,-2.5},{18.3619,-2.5}}));
    end SinusExample;

  end Examples;

  annotation(uses(Modelica(version="3.2")));
end Kotani;
