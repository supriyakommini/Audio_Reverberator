% Prompt user for input: duration and reverberation factor
duration = input('Enter duration of recording in seconds: ');
reverb_factor = input('Enter reverberation factor (gain): ');

% Prompt user to choose recording method
rec_choice = input('Choose recording method: \n1. Record through microphone \n2. Upload existing audio file\n');

if rec_choice == 1
    % Display message to start recording
    disp('Recording... Speak into the microphone.');

    % Create an audio recorder object
    fs = 44100;   % Sampling frequency
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
    
    % Check if the duration of the audio file exceeds 2 minutes
    if size(voice_signal, 1) / fs > 120
        error('The uploaded audio file exceeds the limit of 2 minutes. Please select a shorter audio file.');
    end
    
    % Display the waveform of the audio file
    t = (0:length(voice_signal) - 1) / fs;
    plot(t, voice_signal);
    title('Uploaded Audio File');
    xlabel('Time (s)');
    ylabel('Amplitude');
    
else
    error('Invalid choice. Exiting.');
end

% Apply reverberation effect to the entire audio signal
% Define delay in samples for reverberation effect
delay_samples = round(fs * 0.5); 

% Pad the entire signal with zeros to create a delay
reverberated_signal = [voice_signal; zeros(delay_samples, size(voice_signal, 2))];

% Apply reverberation effect by adding delayed signal with gain
reverberated_signal(delay_samples + 1:end, :) = ...
    reverberated_signal(delay_samples + 1:end, :) + reverb_factor * voice_signal;

% Normalize the reverberated signal
reverberated_signal = reverberated_signal / max(abs(reverberated_signal));

% Play the original voice signal or selected portion
sound(voice_signal, fs);

% Pause for the duration of the recording or selected portion
pause(size(voice_signal, 1) / fs + 1); 

% Play the reverberated signal
sound(reverberated_signal, fs);

% Plot the original voice signal or selected portion
figure;
subplot(2, 1, 1);
plot((0:length(voice_signal) - 1) / fs, voice_signal);
if rec_choice == 1
    title('Recorded Voice Signal');
else
    title('Uploaded Audio File');
end
xlabel('Time (s)');
ylabel('Amplitude');

% Plot the reverberated voice signal
subplot(2, 1, 2);
plot((0:length(reverberated_signal) - 1) / fs, reverberated_signal);
title('Reverberated Voice Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Save the plot as an image file
saveas(gcf, 'reverberation_plot.png');

% Display message indicating completion
disp('Reverberation completed. Signal played and plotted.');
