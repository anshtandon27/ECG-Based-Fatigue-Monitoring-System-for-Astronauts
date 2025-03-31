# ECG-Based Fatigue Monitoring System for Astronauts

## Overview
This repository contains the development of a minimal-electrode ECG monitoring system optimized for detecting astronaut fatigue in space environments. The system extracts both cardiac and respiratory signals from a single ECG input, enabling simultaneous monitoring of heart and breathing rates—key physiological indicators of fatigue states.

## Background & Motivation
Space exploration presents unique physiological challenges for astronauts, including altered sleep patterns and increased cognitive demands that can lead to dangerous levels of fatigue during critical operations. Current monitoring systems often rely on invasive or cumbersome technologies that interfere with an astronaut's mobility and comfort. This project addresses NASA's need for streamlined, non-invasive solutions that can reliably detect early signs of fatigue to prevent accidents and optimize human performance.

As NASA has increasingly adopted wearable technology for monitoring astronaut health, this system contributes to this trend with its minimal sensor footprint and ability to capture multiple physiological parameters simultaneously.

## Key Features
- Non-invasive monitoring using strategically placed electrodes to minimize interference with astronaut mobility
- Dual-parameter extraction of both heart rate and breathing rate from a single ECG signal
- Specialized analog filtering to separate cardiac (0.7-40 Hz) and respiratory (<0.5 Hz) signals
- Real-time physiological assessment with measurements requiring only 30 seconds
- Validated fatigue detection through exercise-induced exhaustion tests

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

## Contributors
B. Kim, J. Kim, N. Kim, A. Tandon, A. Velieva
