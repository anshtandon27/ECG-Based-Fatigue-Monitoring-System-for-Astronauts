df = open('jk.csv');

data = df.data;
time = data(:, 1);

%Select which lead to use 2 --> I, 3 --> II, 4 --> III
lead = data(:, 3);

ecg_filtered = ecgFilter(time, lead);

DC = mean(ecg_filtered);
s = ecg_filtered - DC;

fs = 2000;
Y = fft(s);
L = length(s);
P2 = abs(Y / L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:(L/2)) / L;

figure;
subplot(1, 2, 1);
plot(time(1:10000), ecg_filtered(1:10000));
title('ECG Signal');
xlabel('time (min)');
ylabel('ECG Signal (mV)');

subplot(1, 2, 2);
plot(time(1:10000), s(1:10000));
title('DC Subtracted ECG Signal');
xlabel('time (min)');
ylabel('ECG Signal (mV)');
print('DC_subtract', '-dpng', '-r300');


figure;
hold on
plot(f, P1);
xlim([0 100]);
xlabel('Frequency (Hz)');
ylabel('S(w)^2 (mV^2)');
title('Power Spectrum of ECG Signal');
print('PowerSpectrum', '-dpng', '-r300');
