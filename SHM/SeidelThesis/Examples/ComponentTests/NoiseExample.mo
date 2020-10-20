within SHM.SeidelThesis.Examples.ComponentTests;
model NoiseExample
  import SHM.Shared.Components.Noise.*;
  AutoregressiveGaussianDeg1 noise1(sigma=2, generator.samplePeriod=0.1);
  AutoregressiveGaussianDeg2 noise2(sigma=0.5, generator.samplePeriod=0.01);
  Boolean trigger = sample(0, 0.5);
equation
  noise1.trigger = trigger;
  noise2.trigger = trigger;
end NoiseExample;
