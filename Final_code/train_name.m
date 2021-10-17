function [name1] = train_name(name)  

display('Say your Name now');
display('Start Speaking');  % Displays the string "Start Speaking" in command window
disp('3');
pause(1); disp('2');
pause(1); disp('1');
disp('NOW!!!');
sig = audiorecorder(44100,16,1,1); % Creates an audio recorder object with name 'sig', sampling rate - 44100, bits - 16 and 1 - audio channel
recordblocking(sig,2);           % Records the audio for 2 secs and store it in 'sig' object
display('Stop Speaking');        % Displays the string "Stop Speaking" in command window
name1 = getaudiodata(sig);    % Gets the audio data from 'sig' object and stores it in variable named 'name1'
%plot(name1)
audiowrite(name,name1,44100);% Saves the audio sample with '.wav' extension as mentioned in the input parameter
end