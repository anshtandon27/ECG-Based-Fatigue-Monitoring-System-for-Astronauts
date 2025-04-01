%Finds the heartrate of given filtered ecg

function [avgBR, stdBR] = BreathFinder(time, ecg_filtered)
    M = 100000;
    N = 200000;
    fs = 2000; %Sampling rate
    
    %Find R-peaks. Set minimal peak distance as every 1 second to
    %prevent overlap with other peaks.
    [~, locs] = findpeaks(ecg_filtered(M:N), 'MinPeakHeight', 0.003, 'MinPeakDistance', 1*fs);
    plot(time(M:N), ecg_filtered(M:N));

    
    breath_interval = diff(time(locs)); %RR interval time in minutes
    BR = 1./breath_interval;
    avgBR = mean(BR);
    stdBR = std(BR);
    
    disp(['Breathing Rate: ', num2str(avgBR, '%.2f'), ' ± ', num2str(stdBR, '%.2f'), ' BPM']);
end

