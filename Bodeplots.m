% Read the CSV file
data = readtable('AllBode.csv');

% Extract low pass filter data
fz_low = data{:, 1};  % Column 1: Frequency for low pass
db_low = data{:, 2};  % Column 2: Magnitude for low pass

% Extract band pass filter data
fz_band_raw = data{:, 3};  % Column 3: Frequency for band pass
db_band_raw = data{:, 4};  % Column 4: Magnitude for band pass

% Remove NaN values from band pass data
valid_indices = ~isnan(fz_band_raw) & ~isnan(db_band_raw);
fz_band = fz_band_raw(valid_indices);
db_band = db_band_raw(valid_indices);

% Low-pass Butterworth filter parameters (1st order)
f_c_low = 0.5;  % Cutoff frequency (Hz)
n_low = 1;  % Filter order for Butterworth filter (1st order)

% Generate frequency values for plotting theoretical Bode plot (log scale)
fz_low_theoretical = logspace(log10(min(fz_low)), log10(max(fz_low)), 100);

% Calculate the theoretical magnitude for the low-pass filter (Butterworth)
db_low_theoretical = 20 * log10(1 ./ sqrt(1 + (fz_low_theoretical / f_c_low).^(2*n_low)));

% Band-pass filter parameters (1st order)
f_low = 0.7;  % Lower cutoff frequency (Hz)
f_high = 40;  % Higher cutoff frequency (Hz)
n_band = 1;  % Filter order (1st order)

% Generate frequency values for plotting theoretical Bode plot (log scale)
fz_band_theoretical = logspace(log10(min(fz_band)), log10(max(fz_band)), 100);

% Calculate the theoretical magnitude for the band-pass filter with adjustable order
db_band_theoretical = 20 * log10(... 
    (fz_band_theoretical / f_low).^n_band ./ sqrt(1 + (fz_band_theoretical / f_low).^(2*n_band)) .* ...
    1 ./ sqrt(1 + (fz_band_theoretical / f_high).^(2*n_band))...
);

% Normalize the theoretical curves to match the maximum level of the measured data
% For low pass filter
max_db_low = max(db_low);
max_db_low_theoretical = max(db_low_theoretical);
db_low_theoretical = db_low_theoretical + (max_db_low - max_db_low_theoretical);

% For band pass filter
max_db_band = max(db_band);
max_db_band_theoretical = max(db_band_theoretical);
db_band_theoretical = db_band_theoretical + (max_db_band - max_db_band_theoretical);

% Create a figure with two subplots
figure('Position', [100, 100, 800, 900]);

% Plot Low Pass Filter (scatter plot and theoretical curve)
subplot(2, 1, 1);
scatter(fz_low, db_low, 'b', 'filled');
hold on;
plot(fz_low_theoretical, db_low_theoretical, 'r--', 'LineWidth', 2);
set(gca, 'XScale', 'log');
title('Low Pass Filter Bode Plot');
xlabel('Log-Scale Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;
legend('Experimental', sprintf('Theoretical', n_low), 'Location', 'best');

% Plot Band Pass Filter (scatter plot and theoretical curve)
subplot(2, 1, 2);
scatter(fz_band, db_band, 'g', 'filled');
hold on;
plot(fz_band_theoretical, db_band_theoretical, 'color', [1 0.5 0], 'LineStyle', '--', 'LineWidth', 2);
set(gca, 'XScale', 'log');
title('Band Pass Filter Bode Plot');
xlabel('Log-Scale Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;
legend('Experimental', sprintf('Theoretical', n_band), 'Location', 'northwest');

% Adjust layout
sgtitle('Filter Frequency Response');
