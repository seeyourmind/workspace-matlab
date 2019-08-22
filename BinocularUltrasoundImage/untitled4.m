clear all; close all; clc;
%
%% ∂¡»°Õº∆¨
img = imread('segmentation1_.jpg');
img = imresize(img, 0.1);
imgR = img(:,:,1);
imgG = img(:,:,2);
imgB = img(:,:,3);
%{
figure,
subplot(221),imshow(img);
subplot(222),imshow(imgR);
subplot(223),imshow(imgG);
subplot(224),imshow(imgB);
%}
%{
%% Ã·»°
[m n] = size(imgR);
for i=1:m
    for j=1:n
        if imgR(i,j)<100
            imgR(i,j)=0;
        end
        if imgG(i,j)<100
            imgG(i,j)=0;
        end
        if imgB(i,j)<100
            imgB(i,j)=0;
        end
    end
end
%{
figure,
subplot(221),imshow(img);
subplot(222),imshow(imgR);
subplot(223),imshow(imgG);
subplot(224),imshow(imgB);
%}
%{
for i=1:m
    for j=1:n
        if imgR(i,j)>100 && imgG(i,j)>100 && imgB(i,j)>100
            imgR(i,j)=255;
            imgG(i,j)=255;
            imgB(i,j)=255;
        else
            imgR(i,j)=0;
            imgG(i,j)=0;
            imgB(i,j)=0;
        end
    end
end
figure,
subplot(221),imshow(img);
subplot(222),imshow(imgR);
subplot(223),imshow(imgG);
subplot(224),imshow(imgB);
%}
for i=1:m
    for j=1:n
        if imgR(i,j)~=0 && imgR(i,j) - imgG(i,j)<10 && imgR(i,j)- imgB(i,j)<10 && imgG(i,j)- imgB(i,j)
            imgR(i,j)=255;
        else
            imgR(i,j)=0;
        end
    end
end
bw = im2bw(imgR);
[r c] = find(bw==1);
[rectx, recty, area, perimeter] = minboundrect(c,r,'a');
imshow(bw),hold on
line(rectx, recty, 'color','r','LineWidth', 5);
%}
%{
%% log-gabor
img = imread('tcl.jpg');
imgGary = rgb2gray(img);
imgHist = histeq(imgGary);
figure,
subplot(121),imshow(imgGary);
subplot(122),imshow(imgHist);
[EO, BP] = gaborconvolve(imgHist, 4, 6);
%}
imshow(img),hold on
scatter(49.4506,169.76,'r');
hold off