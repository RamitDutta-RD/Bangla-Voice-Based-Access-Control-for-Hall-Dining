function p = test_name(name)
%display('Say Your Name');
[y, Fs] = audioread('apnarnamebolun.wav'); 
sound(y,Fs);
pause(3);
display('Start Speaking'); % displays the string Start Speaking in command window
% disp('3');
% pause(1); disp('2');
% pause(1); disp('1');
% disp('NOW!!!');
sig = audiorecorder(44100,16,1); % Creates an audio object with 44100 sampling rate, 16-bits and 1-audio channel.
recordblocking(sig,2); % records audio for 3 secs
display('Stop Speaking'); % displays the string Stop Speaking in command window
name1 = getaudiodata(sig); % getting data from audio object as a vector
audiowrite(name,name1,44100); % saving the audio sample in test folder
Fs=44100;
name1=endpointdetectioncode(name1);
% refer to mfcc_c.m file 
Tw=25;
Ts=10;
alpha=0.97;
R = [300 3700];
M = 26;
C = 13;
L = 22;
hamming = @(N)(0.54-0.46*cos(2*pi*[0:N-1].'/(N-1)));
h=hamming(200);
dis=zeros(1,9);
tMFCCs = mfcc_c( name1, 44100, Tw, Ts, alpha, hamming, R, M, C, L );
%tMFCCs= mfcc( name1, Fs);
directory='Train';
sub_dir=dir(['Train/Name/']);
min_val=zeros(1,length(sub_dir));
for idx = 3:length(sub_dir)
    path = [directory,'/Name/',char(sub_dir(idx).name)];
    files = dir([path,'/*.wav']);
    L = length (files);
    dis=zeros(1,L);
    for i=1:L
        entry_str=['Train/Name/',char(sub_dir(idx).name),'/',int2str(i),'.wav'];
        [speaker,Fs]=audioread(entry_str);
        speaker=endpointdetectioncode(speaker);
        MFCCs = mfcc_c(speaker, Fs, Tw, Ts, alpha, hamming, R, M, C, L );
        % MFCCs = mfcc(speaker, Fs);% Calculate MFCC of speaker model
        dis(i) = dtw(tMFCCs,MFCCs);     % find the euclidian distance using "dtw" function and store it in a array
        %display(dis(i));
    end
    min_val(idx)=min(dis);
    %min_val(idx)=sum(dis)/L
end
min_val(1)=[];
min_val(1)=[];
min_val
p=sub_dir(find(min_val==min(min_val))+2).name;