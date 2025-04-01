function HBDuration = Duration(time, E)
    fs = 2000;
    M = 12000;
    N = 18000;
    time = time(M:N);
    E = E(M:N);

    [~, Rlocs] = findpeaks(E, 'MinPeakHeight', 0.7);
    windowB = round(0.2*fs);
    windowA = round(0.35*fs);
    numPeaks = length(Rlocs);
    
    Plocs = [];
    Tlocs = [];
    for i = 1:numPeaks-1
        loc = Rlocs(i);
        [~, P_idx] = min(E(loc-windowB:loc-0.1*fs));
        P_idx = loc - windowB + P_idx - 1;
        [~, T_idx] = min(E(loc+windowB:loc+windowA));
        T_idx = loc + T_idx + windowB - 1;
    
        Plocs = [Plocs, P_idx];
        Tlocs = [Tlocs, T_idx];
    end

    HBDuration = time(Tlocs) - time(Qlocs);
    avg = mean(HBDuration*60);
    stdev = std(HBDuration*60);
    
    disp(['Heart Beat Duration: ', num2str(avg, '%.2f'), ' ± ', num2str(stdev, '%.2f'), ' sec']);
end

