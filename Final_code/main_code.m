clc;
clear all;
close all;

K=1;
while K~=3
    K = menu('Bangla Voice Recognition','New Entry','Test','Exit');
    clc;
    switch K
        
        case 1
            Name=input('Enter your name :','s');
            mkdir (['Train','/','Name','/',Name]); %create a newfolder using your name in Name folder
            %mkdir (['Train','/','Entry','/',Name]);
            %Id=input('Enter your ID :','s');
            mkdir (['Train','/','ID','/',Name]);
            N=input(' How many train dataset you want to create? ==>');
            %             for i=1:N
            %                 filename=['Train/Entry/',Name,'/',int2str(i),'.wav'];
            %                 Entry=train_entry(filename);
            %             end
            for i=1:N
                filename=['Train/Name/',Name,'/',int2str(i),'.wav'];
                Entry=train_name(filename);
            end
            for i=1:N
                filename=['Train/Id/',Name,'/',int2str(i),'.wav'];
                Entry=train_id(filename);
            end
            
        case 2
            
            %p=test_entry('Test/unknown_1.wav')
            q=test_name('Test/unknown_2.wav')
            r=test_id('Test/unknown_3.wav')
            %if strcmp(p,q) && strcmp(q,r)
            if strcmp(q,r)
                [y, Fs] = audioread('apnakeshagotom.wav');
                sound(y,Fs);
%                 pause(3);
%                 display('Access Granted');
                fprintf('Welcome %s',q)
            else
                [y, Fs] = audioread('abarchestakorun.wav');
                sound(y,Fs);
%                 pause(3);
%                 display('Access Denied');
            end
        case 3
            close all;
            
            
    end
end

