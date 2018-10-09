%{
clear;clc;
[im,img,imd,sf,sfg,sfd] = DoubleCrest(imread('8.png'));
figure;
subplot(231);imshow(im);title('原始');
subplot(232);imshow(img);title('灰度');
subplot(233);imshow(imd);title('均值');
subplot(234);imshow(sf);
subplot(235);imshow(sfg);
subplot(236);imshow(sfd);
%}
%{
clear;
im = rgb2gray(imread('1.png'));
count = imhist(im);
p = count./sum(count);
H = zeros(1,256);
p = zeros(1,256);
for i = 1:256
    for j = 1:i
        if total1 ~= 0
            p(j) = count(j)/total1;
        end
        if p(j) ~= 0
            H1 = H1 - (p(j)*log2(p(j)));
        end
    end
    for k = i+1:256
        if total2 ~= 0
            p(k) = count(k)/total2;
        end
        if p(k) ~= 0
            H2 = H2 - (p(k)*log2(p(k)));
        end
    end
    H(i) = H1 + H2;
end
[result, index] = max(H);
%}
%{
function [ result,index ] = MaxEntropy( im )
%ENTROPY 求输入图像的熵
%   im:待求熵图像 result:最大熵值 index:最大熵对应灰度
    im = rgb2gray(im);
    [count, x] = imhist(im);
    total = sum(count);
    result = 0;
    index = 0;
    H1 = 0;
    H2 = 0;
    H = zeros(1,256);
    p = count./total;
    for i = 1:256
        for j = 1:i
            if p(j) ~= 0
                H1 = H1 - (p(j)*log2(p(j)));
            end
        end
        for j = i+1:256
            if p(j) ~= 0
                H2 = H2 - (p(j)*log2(p(j)));
            end
        end
        H(i) = H1 + H2;
    end
    [result, index] = max(H);
end
%}
clc;
clear;
tic;
J = imread('jzx4.jpg');

r = J(:,:,1);
g = J(:,:,2);
b = J(:,:,3);

rh = imhist(r);
gh = imhist(g);
bh = imhist(b);

tic;
[x1,x2,X,Y] = OTSU(J);
t = toc;

rd = DynamicMean(r);
gd = DynamicMean(g);
bd = DynamicMean(b);

ro = OTSU(rd);
go = OTSU(gd);
bo = OTSU(bd);


t = num2str(t);
tt = strcat('运行时间:',t);
figure('color',[1 1 1])
subplot(131),imshow(J),title('原始图像');
subplot(132),imshow(X),title('分割目标图像');
subplot(133),imshow(Y),title('分割背景图像');
figure('color',[1 1 1])
subplot(131),imshow(ro),title('R通道Otsu分割图像');
subplot(132),imshow(go),title('G通道Otsu分割图像');
subplot(133),imshow(bo),title('B通道Otsu分割图像');

%{
subplot(231),imshow(rd),title('R通道灰度图像');
subplot(232),imshow(gd),title('G通道灰度图像');
subplot(233),imshow(bd),title('B通道灰度图像');
subplot(234),bar(rd),title('R通道灰度直方图');
subplot(235),bar(gd),title('G通道灰度直方图');
subplot(236),bar(bd),title('B通道灰度直方图')
%}

%{
[m,n] = size(dco);
p = zeros(m,1);
for i = 1:m
    black = 0;
    white = 0;
    for j = 1:n
        if dco(i,j) == 255
            white = white + 1;
        else
            black = black + 1;
        end
    end
    p(i) = white/black;
end
%}





