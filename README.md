# Real-time Reverberation Effect in MATLAB
- The "Reverberation GUI" is a MATLAB graphical user interface (GUI) application designed for recording, uploading, applying reverberation effects to audio signals, and playing back the original and reverberated audio. The GUI provides users with intuitive controls and visualizations to interact with audio signals.
- The 'audio_reverberator' script records a voice input or an existing audio file can be uploaded, adds reverberation to it, and then plays back both the original and reverberated signals. Additionally, it provides visualizations of the original and reverberated signals.

## 1) [audio_reverberator.m](https://github.com/supriyakommini/Audio_Reverberator/blob/main/audio_reverberator.m)
### Features:
- This code allows the user to choose between recording through the microphone or uploading an audio file.
- After reading the audio file, it checks if the duration of the audio file exceeds 2 minutes (120 seconds).
- If it does, an error is thrown, prompting the user to select a shorter audio file. If the duration is within the limit, the entire audio signal is reverberated.
- Plays back both the original and reverberated signals.
- Displays plots of the original and reverberated signals.
- Saves the plot of the signals as an image file.

### Usage:
- Clone or download the repository.
- Open the MATLAB scripts [audio_reverberator.m](https://github.com/supriyakommini/Audio_Reverberator/blob/main/audio_reverberator.m) in MATLAB or Octave.
- Run the script to record, process, and playback the audio with the reverberation effect.
- Check the generated plot (reverberation_plot.png) to visualize the original and reverberated signals.

### 2)[reverberation_gui.m](https://github.com/supriyakommini/Audio_Reverberator/blob/main/reverberation_gui.m)
### Features:
- Record Audio: Users can record audio input from a microphone for a specified duration.
- Upload Audio: Users can upload audio files (formats supported: .ogg, .flac, .m4a, .wav) for processing.
- Apply Reverberation: Users can apply reverberation effects to the recorded or uploaded audio with a specified reverberation factor.
- Waveform Visualization: The GUI displays the original and reverberated audio waveforms for visual inspection.
- Playback Controls: Users can play, pause, and resume playback of both the original and reverberated audio.

### Usage:
Open the MATLAB scripts 
- Recording:[reverberation_gui.m](https://github.com/supriyakommini/Audio_Reverberator/blob/main/reverberation_gui.m)
1) Click on the "Record" button to initiate audio recording.
2) Enter the desired duration of recording in seconds.
3) Speak into the microphone during the recording.
4) The recorded audio waveform will be displayed in the "Original Audio" plot.

- Uploading:
1) Click on the "Upload Audio" button to select an audio file from your system.
2) Supported audio formats include .ogg, .flac, .m4a, and .wav.
3) Uploaded audio files should not exceed 2 minutes in duration.
4) Applying Reverberation:

- Reverberation:
1) Adjust the "Reverberation Factor" to control the intensity of the reverberation effect.
2) Click on the "Apply Reverberation" button to apply the effect.
3) The reverberated audio waveform will be displayed in the "Reverberated Audio" plot.

- Playback:
1) Use the playback buttons to control playback of both original and reverberated audio.
2) "Play Original": Start playback of the original audio.
3) "Pause Original": Pause playback of the original audio.
4) "Resume Original": Resume playback of the original audio.
5) Similar controls are available for the reverberated audio.

## Requirements:
MATLAB or Octave software.
Compatible microphone for recording audio input.
## Author:
K Supriya


