function main()
%% ʵ�������˲� ˫���˲���Ҳ����ע�������ز��첿�ֵ�Ȩֵ��Ϊgaussian�˲�������ֵ�;�ֵ�˲����Ӻ���ע�͵Ĳ�����Ҳ����ʵ�����˲���
close all
clear
clc
r=4; %r
% %% ˫���˲�
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
%%  matlab �Դ���ֵ�˲�
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
% %% ��ֵ�˲�
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
