# Bangla-Voice-Based-Access-Control-for-Hall-Dining

We present a Bangla voice-based access control system. The system will take speech signal as input from  a user and cross-check with previously recorded inputs from different users. When the system finds a suitable match, it gives a decision on whether the person should be given access or not. The idea is to first extract useful features from raw speech data taken from different users. The technique that is used to extract these features is Mel-Frequency Cepstral Coefficients algorithm which involves calculating coefficients from user audio data that is unique to each user. Then these coefficients are compared with new MFCC coefficients extracted from audio data from a new user using Dynamic Time Warping (DTW) Algorithm. The comparison that yields the minimum value of all DTW comparisons is considered as the match.

Demonstration video <a href="https://youtu.be/1bJfJCFnFjw">link</a>

## Contents

## Workflow Diagram

<p align="center">
  <img src="https://user-images.githubusercontent.com/66994793/137640499-09c59604-a318-49ec-a5cc-8e8a3324ebde.png" title="Work Flow">
</p>


A detailed explanation of the algorithms used in this paper is as follows:-
## End-point detection

In this algorithm, a threshold value is set on the audio amplitude. First, the data is sampled at a high rate. Then the mean and standard deviation of the sampled values are taken. If the (audio amplitude -mean)/(standard deviation) for any audio datum is greater than this threshold value, that data is classified as voiced. Otherwise, that data is classified as unvoiced. Then, frames are declared as having a certain number of samples (such as Fs/100). Then, voiced or unvoiced data are used to classify frames as voiced or unvoiced frames. If the number of voiced data in a frame is greater than the number of unvoiced data in a frame, then that frame is classified as voiced or useful. Otherwise, it is discarded. Then those frames which are classified as voiced are used to make up the silence removed signal.

<p align="center">
  <img src="https://user-images.githubusercontent.com/66994793/137640529-ad2c8da5-1b0e-4b95-b5c5-8ea0c94a31a9.png" title="End-point detection">
</p>




## MFCC Feature Extraction

This technique of feature extraction follows some steps which are as follows:

**(a)	Dividing The Time Signal Into Small Time Frames:** The audio signal at hand is random and fluctuating in nature. The useful information of the signal lies in its power spectrum. If the whole signal’ s power spectrum is analyzed together, then the useful content cannot be found due to the randomness and it becomes difficult to compare coefficients generated at the end of this algorithm. For example, it is not wise to compare  a whole name, say ‘ Ramit ’ with the word ‘ Ramit ’, rather it becomes useful if the audio is divided into parts/frames that are ‘ Ra ’, ‘mi’, ‘t’, and then compare. So, 25ms frames are taken and 10ms is the frame shift duration.

<p align="center">
  <img src="https://user-images.githubusercontent.com/66994793/137640553-85dda05a-5208-4df4-949b-15a0cca68cff.png" title="MFCC">
</p>

**(b) Calculating The Power Spectrum For Each Frame:** After the signal has been divided into frames, each frame is first windowed by a Hamming window. It is important to note, however, that even though the number of samples in each the number of frames is arbitrary depending on the length of the signal. Now after windowing, 2048 point DFT is taken for  each frame. And, the power spectrum is derived from there. The equations are summed up as follows: 
S_frame (k)=∑_(k=0)^(N-1)▒〖s_frame (n)×hamming(n)×e^(-j2πkn/N) 〗                                                                       (1)

Power spectrum of frame i, P_i (k)=∑_(k=0)^N▒〖〖|S〗_i 〖(k)|〗^2 〗       (2)
                                                                                     
**(c) Applying Mel Filterbank on Power Spectrum:** Mel-frequency is another frequency scale which is used to relate the perceived frequency to the measured frequency of audio signals. For example, the difference between hearing a 300 Hz signal followed by a 400Hz signal is not the same as the difference between hearing a 900Hz signal followed by a 1000 Hz signal although the difference in frequency is 100 Hz. Mel-frequency makes these relationships linear, close to how humans hear differentiate these frequencies. In Mel domain, the frequencies are related to frequency in hertz as,
 f=700×〖(e〗^((M(f))/1125)-1).               (3)                                                                                                  
Only 1025 DFT points are used for each frame. Among these 1025 DFT points, a triangular filter bank is applied. Similarly, for 26 such frames, 26 triangular filter banks are applied to the power spectrum. 

**(d)  Taking Log of Energy:** After the filter banks are applied, then the log of the filtered spectrum of each frame is taken. The amount of energy needed to be put into an audio signal to make it sound double as loud as before is not double that of the previous energy. The relation between loudness and frequency components present is not linear. The loudness of 300Hz -3400Hz contents do not increase in a linear manner, rather in an exponential manner. So, we take log of the power spectrum. 

**(e) Discrete Cosine Transform (DCT):** The discrete cosine transform of the log of each power spectrum corresponding to the 26 frames that we are working with gives us 13 coefficients. In essence, the DCT matrix is a 13×26 matrix. This matrix helps to decorrelate the power spectrum overlap between the filterbanks. Now, these are the MFCC coefficients to which classifier will be applied.

**(f) Delta and Delta-deltas:** The mfcc coefficients only contain information of the power spectrum of a single frame. But there might also be information of speech inherent in the dynamics or trajectories of mfcc over time. To quantify these information, mfcc delta and delta-delta coefficients are calculated as follows:
 
                                   d_t=(∑_(n=1)^N▒〖n(c_(t+n)-c_(t-n)) 〗)/(2∑_(n=1)^N▒n^2 )                      (4)

 Here, dt is the delta coefficient of frame t computed from static    coefficients ct+N  to ct-N. N is usually chosen as 2. The delta-delta coefficients are calculated in a similar fashion, except that instead of the static coefficients, delta coefficients are chosen. The mean of all the values of a particular MFCC coefficient for all frames is taken before calculating the delta and the delta-delta coefficients.
 
## Dynamic Time Warping
Dynamic time warping (DTW) is an algorithm used to calculate the difference between two vectors. It is designed to yield a number which represents the difference. In this approach shifts as well as speed of two vectors are ignored. Here, match between points are observed.

### Working Procedure:

**(a) To create Cost matrix:**
If the vectors that we want to compare are of length N, a N×N matrix is formed named Cost matrix. The formula mentioned below is used to calculate the entries of the matrix:

D(i,j)=dist(i,j)+min(D(i,j-1),D(i-1,j),D(i-1,j-1))     (5)  
                                                                                  
Here D(i,j)=entry of  i th column and j th row of the matrix
         dist(i,j)=modulus(i th value of first vector- j th value of second vector)
         D(i,j-1)=entry of  i th column and j-1 th row of the matrix
         D(i-1,j)=entry of  i-1 th column and j th row of the matrix
         D(i-1,j-1)=entry of  i-1 th column and j-1 th row of the matrix
It is an recursive approach because previously calculated values of the cost matrix is used to calculate the newer values.

**(b) To construct Wrap path:**
Here Cost matrix is used to find out the wrap path. Backtracking is done from the N×N th element. We will consider  D(i,j) th element starting from N×N th element and compare the value with D(i,j-1),D(i-1,j) and D(i-1,j-1).Thus the minimum difference point is observed. In this process, we will end up at 1×1 th element. The wrap path is the path from N×N to 1×1 th element in which we found minimum difference with the immediate previous value. The global warp cost is the sum of all the values in the warp path divided by number of elements in the warp path. 

GC=1/p×∑_(k=1)^p▒wi               (6)

Our objective is to calculate the global warp cost from two vectors which indicates the minimum difference between them. 


## Team
- Ramit Dutta (github - https://github.com/RamitDutta)
- Shafin Bin Hamid (github - https://github.com/shafinbinhamid)
- Sudipto Sikder
- Md. Izaz Ahmed

