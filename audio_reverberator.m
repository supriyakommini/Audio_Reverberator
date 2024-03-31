% Prompt user for input: duration and reverberation factor
duration = input('Enter duration of recording in seconds: ');
reverb_factor = input('Enter reverberation factor (gain): ');

% Prompt user to choose recording method
rec_choice = input('Choose recording method: \n1. Record through microphone \n2. Upload existing audio file\n');

if rec_choice == 1
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
elseif rec_choice == 2
    % Prompt user to upload an audio file
    [file, path] = uigetfile({'*.wav;*.ogg;*.flac;*.m4a'}, 'Select Audio File');
    if file == 0
        error('No file selected. Exiting.');
    end

    % Read the audio file
    [voice_signal, fs] = audioread(fullfile(path, file));
else
    error('Invalid choice. Exiting.');
end

% Define delay in samples for reverberation effect
delay_samples = round(fs * 0.5); 

% Add zeros to the beginning of the signal to create a delay
reverberated_signal = [voice_signal; zeros(delay_samples, 1)];

% Apply reverberation effect by adding delayed signal with gain
reverberated_signal(delay_samples + 1:end) = ...
    reverberated_signal(delay_samples + 1:end) + reverb_factor * voice_signal;

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
