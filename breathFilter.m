%Takes time and ecg signal (single lead) as input
%Outputs filtered signal

function ecg_filtered = breathFilter(time, ecg)
    fs = 2000; %Sampling rate
    
    %low pass filter of frequency 0.5 Hz
    fc = 0.5; % Cutoff frequency in Hz
    [b, a] = butter(2, fc/(fs/2), 'low');
    ecg_filtered = filtfilt(b, a, ecg);
end

