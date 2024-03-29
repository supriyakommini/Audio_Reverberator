% Define parameters
duration = 5; % Duration of recording in seconds
fs = 44100;   % Sampling frequency
gain = 0.7;   % Gain for reverberation effect

% Display message to start recording
disp('Recording... Speak into the microphone.');

% Create an audio recorder object
recObj = audiorecorder(fs, 16, 1); 

% Record audio for the specified duration
recordblocking(recObj, duration);

% Display message when recording is complete
disp('Recording complete.');

% Get recorded voice signal data
voice_signal = getaudiodata(recObj);

% Define delay in samples for reverberation effect
delay_samples = round(fs * 0.5); 

% Add zeros to the beginning of the signal to create a delay
reverberated_signal = [voice_signal; zeros(delay_samples, 1)];

% Apply reverberation effect by adding delayed signal with gain
reverberated_signal(delay_samples + 1:end) = ...
    reverberated_signal(delay_samples + 1:end) + gain * voice_signal;

% Normalize the reverberated signal
reverberated_signal = reverberated_signal / max(abs(reverberated_signal));

% Play the original voice signal
sound(voice_signal, fs);

% Pause for the duration of the recording
pause(duration + 1); 

% Play the reverberated signal
sound(reverberated_signal, fs);

% Define time vectors for plotting
time_voice = (0:length(voice_signal) - 1) / fs;
time_reverberated = (0:length(reverberated_signal) - 1) / fs;

% Plot the original voice signal
figure;
subplot(2, 1, 1);
plot(time_voice, voice_signal);
title('Original Voice Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Plot the reverberated voice signal
subplot(2, 1, 2);
plot(time_reverberated, reverberated_signal);
title('Reverberated Voice Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Save the plot as an image file
saveas(gcf, 'reverberation_plot.png');

% Display message indicating completion
disp('Reverberation completed. Signals played and plotted.');  
