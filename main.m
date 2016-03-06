function main()
%% 实现三种滤波 双边滤波（也可以注销掉像素差异部分的权值即为gaussian滤波）、中值和均值滤波（子函数注释的部分中也可以实现锐化滤波）
close all
clear
clc
r=4; %r
% %% 双边滤波
 I=mat2gray(imread('barbara_big.tif')); 
 %I=rgb2gray(I);
I=imnoise(I,'gaussian',0.02);
% for i=1:3
%  I(:,:,i)=dct(double(I(:,:,i)/255));  
% end
% h=fspecial('Gaussian',[5 5],0.1);
% I2=imfilter(I,h,'replicate');
sigma = [5 5]; % bilateral filter standard deviations    
I1=myfilter(I,r,'bilateral',sigma);  
%I1=myfilter(I,r,'Median');
subplot(1,2,1);
imshow(I,[]);
subplot(1,2,2);  
imshow(I,[]); 
% imshow(I1,[]);  
% title('original');
% subplot(1,2,2);
% imshow(I1) 
% title('bilateral preserve edge result') 
%%  matlab 自带中值滤波
% I=imread('test.png');  
% I=imnoise(I,'salt & pepper',0.02);
% I=double(I)/255;    
% I1=myfilter(I,r,'Median');  
% subplot(1,2,1);  
% imshow(I);  
% title('original');
% subplot(1,2,2);   
% imshow(I1)  
% title('median denoise result')
% %% 均值滤波
% I=imread('grass.png');  
% I=double(I)/255;    
% I1=myfilter(I,r,'average');  
% subplot(1,2,1);  
% imshow(I); 
% title('original');
% subplot(1,2,2);  
% imshow(I1,[]) 
% title('average smooth  result') 
% 
