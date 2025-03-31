%Settings for the bode plot
opts = bodeoptions;
opts.FreqUnits = 'Hz';    
opts.MagUnits  = 'dB';    
opts.Grid = 'on';

%Set initial frequency
fMin = 1;       
fMax = 1e4;     
Npts = 1000;    % number of points in the refined freq vector
freq = logspace(log10(fMin), log10(fMax), Npts);  % in Hz
omega= 2*pi*freq;                             % in rad/s

spacer = 5;

s = tf('s');

%Setting up active filter
fc_lp = 50;            
omega0_lp = 2*pi*fc_lp;  
Q_lp = 1/sqrt(2);        
transferFunction = omega0_lp^2 / (s^2 + (omega0_lp/Q_lp)*s + omega0_lp^2);

%Obtain theoretical values
[theoMag, theoPhase] = bode(transferFunction, omega);
theoMag   = squeeze(theoMag);
theoPhase = squeeze(theoPhase);
theoMagDB = 20*log10(theoMag);

%import dataset
data = readtable('lowpass.csv');
expFreq     = table2array(data(:,1));
expMag   = table2array(data(:,3));
expPhase = table2array(data(:,4));

% Downsample
expFreq       = expFreq(1:spacer:end);
expMag     = expMag(1:spacer:end);
expPhase  = expPhase(1:spacer:end);

% Plot
figure;
subplot(2,1,1);
plot(freq, theoMagDB, 'b-','LineWidth',2); hold on; grid on;
scatter(expFreq, expMag, 'r');
set(gca, 'XScale', 'log');
xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');
xlim([0 1e4]);
title('Active LowPass Filter Theoretical vs. Measured (Magnitude)');
legend('Theory','Measured');

subplot(2,1,2);
plot(freq, theoPhase, 'b-','LineWidth',2); hold on; grid on;
scatter(expFreq, expPhase, 'r');
xlabel('Frequency (Hz)'); ylabel('Phase (degrees)');
title('Active LowPass Filter Theoretical vs. Measured (Phase)');
set(gca, 'XScale', 'log');
xlim([0 1e4]);
legend('Theory','Measured');