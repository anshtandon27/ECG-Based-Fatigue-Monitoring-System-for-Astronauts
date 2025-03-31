%Settings for the bode plot
opts = bodeoptions;
opts.FreqUnits = 'Hz';    
opts.MagUnits  = 'dB';    
opts.Grid = 'on';

%Set initial frequency
fMin = 1;       
fMax = 1e4;     
N = 1000;    % number of points
freq = logspace(log10(fMin), log10(fMax), N);  % in Hz
omega = 2*pi*freq;                             % in rad/s

spacer = 5;

s = tf('s');

%Setting up active filter
fc_hp = 50;
omega0_hp = 2*pi*fc_hp;
Q_hp = 1/sqrt(2);
transferFunction = (s^2)/(s^2 + (omega0_hp/Q_hp)*s + omega0_hp^2);

%Obtain theoretical values
[theoMag, thoePhase] = bode(transferFunction, omega);
theoMag   = squeeze(theoMag);
theoPhase = squeeze(thoePhase);
theoMagDB = 20*log10(theoMag);

%import dataset
data = readtable('highpass.csv');
expFreq     = table2array(data(:,1));
expMag   = table2array(data(:,3));
expPhase = table2array(data(:,4)) + 180 ;

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
title('Active HighPass Filter Theoretical vs. Measured (Magnitude)');
legend('Theory','Measured');

subplot(2,1,2);
plot(freq, theoPhase, 'b-','LineWidth',2); hold on; grid on;
scatter(expFreq, expPhase, 'r');
xlabel('Frequency (Hz)'); ylabel('Phase (degrees)');
title('Active HighPass Filter Theoretical vs. Measured (Phase)');
set(gca, 'XScale', 'log');
xlim([0 1e4]);
legend('Theory','Measured');