clear all; close all; clc;
cs = imread('cs_only_sector.png');
cs = imresize(cs,[150,200]);
bgl = imread('noprobel.jpg');
[m,n,c] = size(cs);
for i=1:m
    for j=1:n
        bgl(50+i,70+j,1)=1*bgl(50+i,70+j,1)+0.8*cs(i,j,1);
        bgl(50+i,70+j,2)=1*bgl(50+i,70+j,2)+0.8*cs(i,j,2);
        bgl(50+i,70+j,3)=1*bgl(50+i,70+j,3)+0.8*cs(i,j,3);
    end
end
bgr = imread('noprober.jpg');
for i=1:m
    for j=1:n
        bgr(50+i,50+j,1)=1*bgr(50+i,50+j,1)+0.8*cs(i,j,1);
        bgr(50+i,50+j,2)=1*bgr(50+i,50+j,2)+0.8*cs(i,j,2);
        bgr(50+i,50+j,3)=1*bgr(50+i,50+j,3)+0.8*cs(i,j,3);
    end
end
subplot(131),imshow(cs);
subplot(132),imshow(bgl);
subplot(133),imshow(bgr);
imwrite(bgr,'noprobe1done.jpg');
imwrite(bgl,'noproberdone.jpg');