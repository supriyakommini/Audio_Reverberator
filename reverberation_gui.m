function reverberation_gui
    % Create GUI window
    fig = figure('Position', [200, 200, 1000, 800], 'MenuBar', 'none', 'ToolBar', 'none', 'Name', 'Reverberation GUI');
    
    % Axes for waveform display
    axes_waveform = axes('Position', [0.1, 0.55, 0.8, 0.25]);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title('Original Audio');
    
    % Axes for reverberated waveform display
    axes_reverb_waveform = axes('Position', [0.1, 0.15, 0.8, 0.25]);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title('Reverberated Audio');
    
    % UI components
    uicontrol('Style', 'text', 'String', 'Reverberation Factor:', 'Position', [20, 750, 140, 20]);
    reverb_factor_edit = uicontrol('Style', 'edit', 'Position', [160, 750, 50, 20]);
    
    rec_button = uicontrol('Style', 'pushbutton', 'String', 'Record', 'Position', [35, 700, 100, 30], 'Callback', @record_callback);
    upload_button = uicontrol('Style', 'pushbutton', 'String', 'Upload Audio', 'Position', [155, 700, 120, 30], 'Callback', @upload_callback);
    apply_button = uicontrol('Style', 'pushbutton', 'String', 'Apply Reverberation', 'Position', [295, 700, 150, 30], 'Callback', @apply_callback);
    play_orig_button = uicontrol('Style', 'pushbutton', 'String', 'Play Original', 'Position', [320, 365, 100, 30], 'Callback', @play_orig_callback);
    pause_orig_button = uicontrol('Style', 'pushbutton', 'String', 'Pause Original', 'Position', [440, 365, 120, 30], 'Callback', @pause_orig_callback);
    resume_orig_button = uicontrol('Style', 'pushbutton', 'String', 'Resume Original', 'Position', [580, 365, 120, 30], 'Callback', @resume_orig_callback);
    play_reverb_button = uicontrol('Style', 'pushbutton', 'String', 'Play Reverberated', 'Position', [290, 40, 120, 30], 'Callback', @play_reverb_callback);
    pause_reverb_button = uicontrol('Style', 'pushbutton', 'String', 'Pause Reverberated', 'Position', [430, 40, 150, 30], 'Callback', @pause_reverb_callback);
    resume_reverb_button = uicontrol('Style', 'pushbutton', 'String', 'Resume Reverberated', 'Position', [600, 40, 150, 30], 'Callback', @resume_reverb_callback);

    % Store voice_signal and fs in appdata
    setappdata(fig, 'voice_signal', []);
    setappdata(fig, 'fs', []);
    setappdata(fig, 'orig_player', []);
    setappdata(fig, 'reverb_player', []);
    
    % Callback functions
    function record_callback(~, ~)
        prompt = {'Enter duration of recording in seconds:'};
        dlg_title = 'Recording Duration';
        num_lines = 1;
        default_answer = {'5'}; % Default duration
        answer = inputdlg(prompt,dlg_title,num_lines,default_answer);
        if isempty(answer)
            return; % User canceled recording
        end
        duration = str2double(answer{1});
        recObj = audiorecorder(44100, 16, 1);
        disp('Recording... Speak into the microphone.');
        recordblocking(recObj, duration);
        disp('Recording complete.');
        voice_signal = getaudiodata(recObj);
        fs = recObj.SampleRate; % Get the sampling frequency
        setappdata(fig, 'voice_signal', voice_signal);
        setappdata(fig, 'fs', fs);
        plot_waveform(voice_signal, fs, axes_waveform);
    end

    function upload_callback(~, ~)
        [file, path] = uigetfile({'.ogg';'.flac';'.m4a';'.wav'}, 'Select Audio File');
        if file == 0
            return; % User canceled file selection, so just return
        end
        info = audioinfo(fullfile(path, file));
        if info.Duration > 120 % Check duration
            errordlg('The uploaded audio file exceeds the limit of 2 minutes. Please select a shorter audio file.', 'File Duration Exceeded');
            return;
        end
        [voice_signal, fs] = audioread(fullfile(path, file));
        setappdata(fig, 'voice_signal', voice_signal);
        setappdata(fig, 'fs', fs);
        plot_waveform(voice_signal, fs, axes_waveform);
    end

    function apply_callback(~, ~)
        voice_signal = getappdata(fig, 'voice_signal');
        fs = getappdata(fig, 'fs');
        if isempty(voice_signal) || isempty(fs)
            errordlg('No audio data available. Please record or upload an audio file.', 'No Audio Data');
            return;
        end
        reverb_factor = str2double(get(reverb_factor_edit, 'String'));
        delay_samples = round(fs * 0.5);
        reverberated_signal = [voice_signal; zeros(delay_samples, size(voice_signal, 2))];
        reverberated_signal(delay_samples + 1:end, :) = ...
            reverberated_signal(delay_samples + 1:end, :) + reverb_factor * voice_signal;
        reverberated_signal = reverberated_signal / max(abs(reverberated_signal));
        plot_waveform(reverberated_signal, fs, axes_reverb_waveform);
    end

    function play_orig_callback(~, ~)
        voice_signal = getappdata(fig, 'voice_signal');
        fs = getappdata(fig, 'fs');
        if isempty(voice_signal) || isempty(fs)
            errordlg('No audio data available. Please record or upload an audio file.', 'No Audio Data');
            return;
        end
        orig_player = audioplayer(voice_signal, fs);
        setappdata(fig, 'orig_player', orig_player);
        play(orig_player);
    end

    function pause_orig_callback(~, ~)
        orig_player = getappdata(fig, 'orig_player');
        if ~isempty(orig_player)
            pause(orig_player);
        end
    end

    function resume_orig_callback(~, ~)
        orig_player = getappdata(fig, 'orig_player');
        if ~isempty(orig_player)
            resume(orig_player);
        end
    end

    function play_reverb_callback(~, ~)
        voice_signal = getappdata(fig, 'voice_signal');
        fs = getappdata(fig, 'fs');
        if isempty(voice_signal) || isempty(fs)
            errordlg('No audio data available. Please record or upload an audio file.', 'No Audio Data');
            return;
        end
        reverb_factor = str2double(get(reverb_factor_edit, 'String'));
        delay_samples = round(fs * 0.5);
        reverberated_signal = [voice_signal; zeros(delay_samples, size(voice_signal, 2))];
        reverberated_signal(delay_samples + 1:end, :) = ...
            reverberated_signal(delay_samples + 1:end, :) + reverb_factor * voice_signal;
        reverberated_signal = reverberated_signal / max(abs(reverberated_signal));
        reverb_player = audioplayer(reverberated_signal, fs);
        setappdata(fig, 'reverb_player', reverb_player);
        play(reverb_player);
    end

    function pause_reverb_callback(~, ~)
        reverb_player = getappdata(fig, 'reverb_player');
        if ~isempty(reverb_player)
            pause(reverb_player);
        end
    end

    function resume_reverb_callback(~, ~)
        reverb_player = getappdata(fig, 'reverb_player');
        if ~isempty(reverb_player)
            resume(reverb_player);
        end
    end

    function plot_waveform(signal, fs, ax)
        t = (0:length(signal) - 1) / fs;
        axes(ax);
        plot(t, signal);
    end
end