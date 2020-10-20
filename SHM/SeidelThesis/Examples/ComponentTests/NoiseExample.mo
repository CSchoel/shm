within SHM.SeidelThesis.Examples.ComponentTests;
model NoiseExample
  import SHM.Shared.Components.Noise.*;
  AutoregressiveGaussianDeg1 noise1(sigma=2, r_last=0.9, generator.samplePeriod=0.1);
  AutoregressiveGaussianDeg2 noise2(sigma=0.5, r_last1=0.5, r_last2=0.25, generator.samplePeriod=0.01);
  inner Modelica.Blocks.Noise.GlobalSeed globalSeed;
  Boolean trigger = sample(0, 0.5);
equation
  noise1.trigger = trigger;
  noise2.trigger = trigger;
end NoiseExample;
