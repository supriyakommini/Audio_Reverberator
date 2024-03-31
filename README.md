# Real-time Reverberation Effect in MATLAB
This MATLAB script demonstrates how to apply a real-time reverberation effect to an audio signal recorded from a microphone. The script records a voice input, adds reverberation to it, and then plays back both the original and reverberated signals. Additionally, it provides visualizations of the original and reverberated signals.

## Features:
- This code allows the user to choose between recording through the microphone or uploading an audio file.
- After reading the audio file, it checks if the duration of the audio file exceeds 2 minutes (120 seconds).
-  If it does, an error is thrown, prompting the user to select a shorter audio file. If the duration is within the limit, the entire audio signal is reverberated.
- Plays back both the original and reverberated signals.
- Displays plots of the original and reverberated signals.
- Saves the plot of the signals as an image file.
## Usage:
Clone or download the repository.
Open the MATLAB script [audio_reverberator.m](https://github.com/supriyakommini/Audio_Reverberator/blob/main/audio_reverberator.m) in MATLAB or Octave.
Run the script to record, process, and playback the audio with the reverberation effect.
Check the generated plot (reverberation_plot.png) to visualize the original and reverberated signals.
Requirements:
MATLAB or Octave software.
Compatible microphone for recording audio input.
## Author:
K Supriya


