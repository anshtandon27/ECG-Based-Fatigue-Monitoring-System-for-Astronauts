%Settings for the bode plot
opts = bodeoptions;
opts.FreqUnits = 'Hz';
opts.MagUnits = 'dB';
opts.Grid = 'on';

%Set initial frequency
fMin = 1; %Minimum frequency
fMax = 1e4; %Maximum frequency
N = 1000; %Number of points
freq_vec = logspace(log10(fMin), log10(fMax), N); %
omega_vec = 2*pi*freq_vec; %

s = tf('s');

%Resistor and transistor values
R_RC = 33e3;
C_RC = 1e-7;
H_RC_HP = (s*R_RC*C_RC) / (1 + s*R_RC*C_RC);

%Evaluate theoretical Bode
[theoMag, theoPhase] = bode(H_RC_HP, omega_vec);
theoMag = squeeze(theoMag);
theoPhase = squeeze(theoPhase);
theoMagDB = 20*log10(theoMag);

%Import Data
df = readtable('bode.xlsx', 'Sheet', 'Passive');
expFreq = table2array(df(:, 1));
expMag = table2array(df(:, 7));
expPhase = table2array(df(:, 8));

%Plotting
figure;
% Subplot 1: Magnitude
subplot(2,1,1);
plot(freq_vec, theoMagDB, 'b-','LineWidth',2); hold on; grid on;
scatter(expFreq, expMag, 'r');
set(gca, 'XScale', 'log');
xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');
title('RC High-Pass: Theoretical vs. Measured (Magnitude)');
legend('Theory','Measured');

subplot(2,1,2);
plot(freq_vec, theoPhase, 'b-','LineWidth',2); hold on; grid on;
scatter(expFreq, expPhase, 'r');
set(gca, 'XScale', 'log');
xlabel('Frequency (Hz)'); ylabel('Phase (degrees)');
title('RC High-Pass: Theoretical vs. Measured (Phase)');
legend('Theory','Measured');

