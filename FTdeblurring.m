% Course             : Digital Signal Processing
% Project            : Image Deblurring using FFT 
% Group Members Name : Dhruti Chandarana (201501015)
%                      Charmi Chokshi (201501021)
%                      Janvi Patel (201501072)
%                      Nishi Patel (201501076)
% Date               : 10/5/2018


close all; 
clear all; 

Imageinp = input('Enter Image name : '); 

%To convert image into jpg image
fil={Imageinp};  
for k=1:numel(fil)
  file=fil{k};
  new_file=strrep(file,'.*','.jpg');
  im=imread(file);
  imwrite(im,new_file);
end

y = rgb2gray((imread(new_file)));   %convert rgb to gray scale image
y = im2double(y); 

% linear motion of a camera by len pixels, with an angle of theta degrees in a counterclockwise direction
LEN = 21;
THETA = 11;
%take motion psf
PSF = fspecial('motion',LEN,THETA);   %%Approximates the linear motion of a camera
 
%convolve image with psf
yblur = conv2(y,PSF);
 
%%noise if added

% noise_mean = 0;
% noise_var = 0.0001;
% blurred_noisy = imnoise(yblur, 'gaussian', ...
%                          noise_mean, noise_var);
                     
figure(); 
subplot(1,2,1); imshow(yblur); title('Actual image');
 

%use simple X = Y/H to get back original image
%show how much noise affects it
Y1 = fft2(yblur); 
 
%zero pad the psf to match the size of the blurred image
%noisy images are all the same size, thus do not require unique PSF's
newh = zeros(size(yblur)); 
psfsize = size(PSF); 
newh(1: psfsize(1), 1:psfsize(2))= PSF;
H = fft2(newh); %fft of blurring function
 
y1deblurred = ifft2(Y1./H);

subplot(1,2,2);imshow(y1deblurred);title('Deblurred image using FFT ');
