%Takes time and ecg signal (single lead) as input
%Outputs filtered signal

function ecg_filtered = ecgFilter(time, ecg)
    fs = 2000; %Sampling rate
    
    %High-pass filter for 0.7 Hz
    fc = 0.7; % Cutoff frequency in Hz
    [b, a] = butter(2, fc/(fs/2), 'high');
    ecg_filtered = filtfilt(b, a, ecg);

    %Low-pass filter for 20 Hz
    fc = 20; % Cutoff frequency in Hz
    [b, a] = butter(2, fc/(fs/2), 'low');
    ecg_filtered = filtfilt(b, a, ecg_filtered);
end

