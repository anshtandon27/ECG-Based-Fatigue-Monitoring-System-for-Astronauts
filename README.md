# ECG-Based Fatigue Monitoring System for Astronauts
## Overview
This repository contains the implementation of a minimal-electrode ECG monitoring system designed for detecting astronaut fatigue in space environments. The system extracts both cardiac and respiratory signals from a single ECG input, enabling simultaneous monitoring of heart and breathing rates—key physiological indicators of fatigue states.

Space exploration presents unique physiological challenges for astronauts, including altered sleep patterns and increased cognitive demands that can lead to dangerous levels of fatigue during critical operations. Our system addresses NASA's need for streamlined, non-invasive solutions that can reliably detect early signs of fatigue to prevent accidents and optimize human performance.

## Key Features
- **Non-invasive monitoring** using strategically placed electrodes to minimize interference with astronaut mobility
- **Dual-parameter extraction** of both heart rate and breathing rate from a single ECG signal
- Specialized **analog filtering** to separate cardiac (0.7-40 Hz) and respiratory (<0.5 Hz) signals
- **Real-time physiological assessment** with measurements requiring only 30 seconds
- **Validated fatigue detection** through exercise-induced exhaustion tests

## System Design
### Hardware Components
- ECG electrodes in Lead II configuration (positive lead on left leg, negative on right arm, ground on left arm)
- Instrumentation amplifier (INA126) with gain of 5 for signal amplification
- Universal active filter chip (UAF42) for signal conditioning
- Second-order Butterworth filters for frequency separation

### Signal Processing Pipeline
1. Raw ECG acquisition and amplification
2. FFT analysis to identify noise components (20-60 Hz)
3. Band-pass filtering (0.7-40 Hz) for clean ECG extraction
4. Low-pass filtering (<0.5 Hz) for breathing signal isolation
5. Peak detection algorithms for R-peak identification with 200-ms refractory period
6. Feature extraction for heart rate, breathing rate, QT interval, and heartbeat duration

## Code Functionality
### Signal Filtering
- **ecgFilter.m:** Implements a digital bandpass filter (0.7-20 Hz) using a Butterworth filter to clean ECG signals
- **breathFilter.m:** Implements a lowpass filter (<0.5 Hz) using a Butterworth filter to extract breathing signals
- **highPassActive.m:** Implements a second-order active high-pass filter with a 50 Hz cutoff frequency using UAF42
- **lowPassActive.m:** Implements a second-order active low-pass filter with a 50 Hz cutoff frequency using UAF42
- **highPassRC.m:** Implements a passive RC high-pass filter for comparison with active filters

### Feature Extraction
- **HRFinder.m:** Calculates average heart rate from R-peaks in the filtered ECG signal
- **InstantaneousFinder.m:** Computes the instantaneous heart rate over time
- **QTFinder.m:** Extracts the QT interval duration from the ECG signal
- **Duration.m:** Measures the total heartbeat duration (Q-wave onset to T-wave offset)
- **BreathFinder.m:** Calculates the average breathing rate from filtered breathing signal

### Visualization and Analysis
- **Bodeplots.m:** Generates Bode plots comparing theoretical and experimental filter responses
- **FrequencyDomainAnalysis.m:** Performs FFT analysis of ECG signals to identify frequency components

## Results
Our system successfully demonstrated:
- Clean extraction of both ECG and breathing signals through optimized filtering
- Significant physiological response to exhaustion:
  - Rested state: Heart rate 88.95 ± 19.73 bpm, breathing rate 14.89 ± 1.32 bpm
  - Exhausted state: Heart rate 153.64 ± 19.05 bpm, breathing rate 34.76 ± 8.57 bpm
- Stable baseline parameters: QT interval and heartbeat duration remained consistent regardless of exhaustion level

## Filter Implementation
The repository includes two types of filter implementations:
- Digital Filters built in MATLAB
  - Butterworth filters implemented in **ecgFilter.m** with configurable cutoff frequencies
  - Used for initial signal processing and analysis
- Analog Filters (Hardware)
  - Active filters using UAF42 universal active filter chip
  - Passive RC filters for comparison and educational purposes
  - Bode plots demonstrate frequency response characteristics

Both approaches were validated by comparing theoretical frequency responses with measured data, showing excellent agreement in the frequency ranges of interest.

## Contributors
B. Kim, J. Kim, N. Kim, A. Tandon, A. Velieva
