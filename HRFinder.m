%Finds the heartrate of given filtered ecg

function [avgHR, stdHR] = HRFinder(time, ecg_filtered)
    M = 1;
    N = 50000;
    fs = 2000; %Sampling rate
    
    %Find R-peaks. Set minimal peak distance as every 0.3 seconds to
    %prevent overlap with other peaks.
    [~, locs] = findpeaks(ecg_filtered, 'MinPeakHeight', 0.3, 'MinPeakDistance', 0.3*fs);

    % figure;
    % hold on
    % T = time(M:N);
    % S = ecg_filtered(M:N);
    % plot(T, ecg_filtered(M:N));
    % scatter(T(locs), S(locs));
    
    RR_intervals = diff(time(locs)); %RR interval time in minutes
    HR = 1./RR_intervals;
    avgHR = mean(HR);
    stdHR = std(HR);
    
    disp(['Heart Rate: ', num2str(avgHR, '%.2f'), ' ± ', num2str(stdHR, '%.2f'), ' BPM']);
end

