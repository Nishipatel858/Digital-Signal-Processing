% Course             : Digital Signal Processing
% Project            : Image Deblurring using wiener method
% Group Members Name : Dhruti Chandarana (201501015)
%                      Charmi Chokshi (201501021)
%                      Janvi Patel (201501072)
%                      Nishi Patel (201501076)
% Date               : 10/5/2018


close all; 
clear all; 

Imageinp = input('Enter Image name : '); 
I = rgb2gray(im2double(imread(Imageinp)));  %convert rgb to gray scale image

% linear motion of a camera by len pixels, with an angle of theta degrees in a counterclockwise direction
LEN = 21;
THETA = 11;
PSF = fspecial('motion',LEN,THETA);   %Approximates the linear motion of a camera
blurred = imfilter(I, PSF, 'conv', 'circular'); %circular convolution of PSF with Actual image to give blurry effect
subplot(1,2,1);imshow(blurred);
title('Actual image');

noise_mean = 0; %mean of noise
noise_var = 0.0001; %variance of noise
% blurred_noisy = imnoise(blurred, 'gaussian', ...
%                          noise_mean, noise_var);    %add gaussian noise 

estimated_nsr = noise_var / var(I(:));  %should be less than 1: constant k
wnr3 = deconvwnr(blurred, PSF, estimated_nsr);  % (H*)/(H^2 + k)
subplot(1,2,2);imshow(wnr3);
title('Deblurred image using wiener');