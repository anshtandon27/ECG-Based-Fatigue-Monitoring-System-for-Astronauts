function HBDuration = Duration(time, E)
    fs = 2000;
    [~, Rlocs] = findpeaks(E, 'MinPeakHeight', 0.3);
    windowB = round(0.2*fs);
    windowA = round(0.35*fs);
    numPeaks = length(Rlocs);
    
    Qlocs = [];
    Tlocs = [];
    for i = 2:numPeaks-1
        loc = Rlocs(i);
        [~, Q_idx] = min(E(loc-windowB:loc-0.1*fs));
        Q_idx = loc - windowB + Q_idx - 1;
        [~, T_idx] = min(E(loc+windowB:loc+windowA));
        T_idx = loc + T_idx + windowB - 1;
    
        Qlocs = [Qlocs, Q_idx];
        Tlocs = [Tlocs, T_idx];
    end
    
    HBDuration = time(Tlocs) - time(Qlocs);
    avg = mean(HBDuration*60);
    stdev = std(HBDuration*60);
    
    disp(['Heart Beat Duration: ', num2str(avg, '%.2f'), ' ± ', num2str(stdev, '%.2f'), ' sec']);
end

