close all;

display('Start Speaking'); % displays the string Start Speaking in command window
disp('3');
pause(1); disp('2');
pause(1); disp('1');
disp('NOW!!!');
sig = audiorecorder(44100,16,1); % Creates an audio object with 44100 sampling rate, 16-bits and 1-audio channel.
recordblocking(sig,3); % records audio for 3 secs
display('Stop Speaking'); % displays the string Stop Speaking in command window
name1 = getaudiodata(sig); % getting data from audio object as a vector
audiowrite('abarchestakorun.wav',name1,44100);% saving the audio sample in test folder
sound(name1,44100);