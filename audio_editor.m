System 2 - Audio Editor

num_audio_signals =input('Enter the number of audio signals (2 or 3): ');
[file1,fs1] = audioread('Arcade game over sound effect!.wav');
player1 = audioplayer(file1, fs1);
[file2,fs2] = audioread('Among us sus sound effect.wav');
player2 = audioplayer(file2, fs2);

num_seconds1 = input('Enter the number of seconds for the first audio segment: ');

num_seconds2 = input('Enter the number of seconds for the second audio segment: ');

if num_audio_signals == 3
    
    [file3, fs3] = audioread('backgroundmusic_1.wav');
    player3 = audioplayer(file3, fs3);
    
    num_seconds3 = input('Enter the number of seconds for the third audio segment: ');
 
    if fs1 ~= fs2
        file2 = resample(file2, fs1, fs2);
        fs2 = fs1;
    end
    
    if fs1 ~= fs3
        file3 = resample(file3, fs1, fs3);
        fs3 = fs1;
    end
    
    num_samples1 = round(num_seconds1 * fs1);
    num_samples2 = round(num_seconds2 * fs1);
    num_samples3 = round(num_seconds3 * fs1);
    
    segment1 = file1(1:num_samples1, :);
    segment2 = file2(1:num_samples2, :);
    segment3 = file3(1:num_samples3, :);
    
    combine_audio = [segment1; segment2; segment3 ];
else
  
    if fs1 ~= fs2
        file2 = resample(file2, fs1, fs2);
        fs2 = fs1;
    end
    
    num_samples1 = round(num_seconds1 * fs1);
    num_samples2 = round(num_seconds2 * fs1);
    
    segment1 =file1(1:num_samples1, :);
    segment2 =file2(1:num_samples2, :);
    
    combined_audio = [segment1; segment2 ];
end

combined_player = audioplayer(combined_audio, fs1);

plot(combined_audio);
title('Combined Audio');

play(combined_player);