%Finds duration of heartbeat

function [T, instBPM] = InstantaneousFinder(time, ecg_filtered)
    fs = 2000; %Sampling rate
    
    %Find R-peaks. Set minimal peak distance as every 0.2 seconds to
    %prevent overlap with other peaks.
    [~, locs] = findpeaks(ecg_filtered, 'MinPeakHeight', 0.7, 'MinPeakDistance', 0.2*fs);
    
    RR_intervals = diff(time(locs)); %RR interval time in minutes
    T = time(locs(2:end));
    instBPM = 1./RR_intervals;

end

