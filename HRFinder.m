%Finds the heartrate of given filtered ecg

function [avgHR, stdHR] = HRFinder(time, ecg_filtered)
    M = 50000;
    N = 100000;
    fs = 2000; %Sampling rate
    
    %Find R-peaks. Set minimal peak distance as every 0.2 seconds to
    %prevent overlap with other peaks.
    [~, locs] = findpeaks(ecg_filtered(M:N), 'MinPeakHeight', 0.7, 'MinPeakDistance', 0.2*fs);
    
    RR_intervals = diff(time(locs)); %RR interval time in minutes
    HR = 1./RR_intervals;
    avgHR = mean(HR);
    stdHR = std(HR);
    
    disp(['Heart Rate: ', num2str(avgHR, '%.2f'), ' ± ', num2str(stdHR, '%.2f'), ' BPM']);
end

