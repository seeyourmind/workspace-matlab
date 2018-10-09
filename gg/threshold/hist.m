clear;clc;
%{
figure;
im=imread('1.png'); %文件名为1.jpg的图像，放在c盘底下，当然路径都可以自己改
if size(im,3)>1  %判断如果是彩色图像，转换为灰度图
    im=im(:,:,2);
end
hist_im=imhist(im); %计算直方图
subplot(241);
xlabel('辊印');
plot(hist_im);%画直方图  
%%%
im=imread('2.png'); %文件名为1.jpg的图像，放在c盘底下，当然路径都可以自己改
if size(im,3)>1  %判断如果是彩色图像，转换为灰度图
    im=im(:,:,2);
end
hist_im=imhist(im); %计算直方图
subplot(242);
xlabel('粘结');
plot(hist_im);%画直方图
%%%
im=imread('3.png'); %文件名为1.jpg的图像，放在c盘底下，当然路径都可以自己改
if size(im,3)>1  %判断如果是彩色图像，转换为灰度图
    im=im(:,:,2);
end
hist_im=imhist(im); %计算直方图
subplot(243);
xlabel('压痕');
plot(hist_im);%画直方图
%%%
im=imread('4.png'); %文件名为1.jpg的图像，放在c盘底下，当然路径都可以自己改
if size(im,3)>1  %判断如果是彩色图像，转换为灰度图
    im=im(:,:,2);
end
hist_im=imhist(im); %计算直方图
subplot(244);
xlabel('折痕');
plot(hist_im);%画直方图
%%%
im=imread('5.png'); %文件名为1.jpg的图像，放在c盘底下，当然路径都可以自己改
if size(im,3)>1  %判断如果是彩色图像，转换为灰度图
    im=im(:,:,2);
end
hist_im=imhist(im); %计算直方图
subplot(245);
xlabel('结疤');
plot(hist_im);%画直方图
%%%
im=imread('6.png'); %文件名为1.jpg的图像，放在c盘底下，当然路径都可以自己改
if size(im,3)>1  %判断如果是彩色图像，转换为灰度图
    im=im(:,:,2);
end
hist_im=imhist(im); %计算直方图
subplot(246);
xlabel('气泡');
plot(hist_im);%画直方图
%%%
im=imread('7.png'); %文件名为1.jpg的图像，放在c盘底下，当然路径都可以自己改
if size(im,3)>1  %判断如果是彩色图像，转换为灰度图
    im=im(:,:,2);
end
hist_im=imhist(im); %计算直方图
subplot(247);
xlabel('划伤');
plot(hist_im);%画直方图
%%%
im=imread('8.png'); %文件名为1.jpg的图像，放在c盘底下，当然路径都可以自己改
if size(im,3)>1  %判断如果是彩色图像，转换为灰度图
    im=im(:,:,2);
end
hist_im=imhist(im); %计算直方图
subplot(248);
xlabel('氧化');
plot(hist_im);%画直方图
figure;
im=imread('1.png'); %文件名为1.jpg的图像，放在c盘底下，当然路径都可以自己改
im=DynamicMean(im);
hist_im=imhist(im); %计算直方图
subplot(241);
xlabel('辊印');
plot(hist_im);%画直方图  
%%%
im=imread('2.png'); %文件名为1.jpg的图像，放在c盘底下，当然路径都可以自己改
im=DynamicMean(im);
hist_im=imhist(im); %计算直方图
subplot(242);
xlabel('粘结');
plot(hist_im);%画直方图
%%%
im=imread('3.png'); %文件名为1.jpg的图像，放在c盘底下，当然路径都可以自己改
im=DynamicMean(im);
hist_im=imhist(im); %计算直方图
subplot(243);
xlabel('压痕');
plot(hist_im);%画直方图
%%%
im=imread('4.png'); %文件名为1.jpg的图像，放在c盘底下，当然路径都可以自己改
im=DynamicMean(im);
hist_im=imhist(im); %计算直方图
subplot(244);
xlabel('折痕');
plot(hist_im);%画直方图
%%%
im=imread('5.png'); %文件名为1.jpg的图像，放在c盘底下，当然路径都可以自己改
im=DynamicMean(im);
hist_im=imhist(im); %计算直方图
subplot(245);
xlabel('结疤');
plot(hist_im);%画直方图
%%%
im=imread('6.png'); %文件名为1.jpg的图像，放在c盘底下，当然路径都可以自己改
im=DynamicMean(im);
hist_im=imhist(im); %计算直方图
subplot(246);
xlabel('气泡');
plot(hist_im);%画直方图
%%%
im=imread('7.png'); %文件名为1.jpg的图像，放在c盘底下，当然路径都可以自己改
im=DynamicMean(im);
hist_im=imhist(im); %计算直方图
subplot(247);
xlabel('划伤');
plot(hist_im);%画直方图
%%%
im=imread('8.png'); %文件名为1.jpg的图像，放在c盘底下，当然路径都可以自己改
im=DynamicMean(im);
hist_im=imhist(im); %计算直方图
subplot(248);
xlabel('氧化');
plot(hist_im);%画直方图
%}
im=imread('../image/2.png'); %文件名为1.jpg的图像，放在c盘底下，当然路径都可以自己改
im=DynamicMean(im);
h=entropy(im);
hist_im=imhist(im); %计算直方图
plot(hist_im);%画直方图

A0=imread('../image/2.png');  %读入图像
seed=[100,220];         %选择起始位置
thresh=16;             %相似性选择阈值
A=rgb2gray(A0); %灰度化
A=imadjust(A,[min(min(double(A)))/255,max(max(double(A)))/255],[]);
A=double(A);          
B=A;                 
[r,c]=size(B);            %图像尺寸 r为行数，c为列数
n=r*c;                 %计算图像所包含点的个数
pixel_seed=A(seed(1),seed(2)); 
q=[seed(1) seed(2)];      %q用来装载起始位置
top=1;                 
M=zeros(r,c);            %建立一个与原图形同等大小的矩阵
M(seed(1),seed(2))=1;     %将起始点赋为1，其余为0
count=1;       %计数器
while top~=0    %循环结束条件
r1=q(1,1);      %起始点行位置
c1=q(1,2);      %起始点列位置
p=A(r1,c1);     %起始点灰度值
dge=0;
for i=-1:1 
for j=-1:1
if r1+i<=r && r1+i>0 && c1+j<=c && c1+j>0 
if abs(A(r1+i,c1+j)-p)<=thresh && M(r1+i,c1+j)~=1
top=top+1; 
q(top,:)=[r1+i c1+j];%将满足判定条件的周围点的位置赋予q，q记载了满足判定的每一外点
M(r1+i,c1+j)=1;  %满足判定条件将M中相对应的点赋为1
count=count+1;  %统计满足判定条件的点个数，其实与top此时的值一样
B(r1+i,c1+j)=1;   %满足判定条件将B中相对应的点赋为1
end
if M(r1+i,c1+j)==0; 
dge=1;          %将dge赋为1
end
else
dge=1;          %点在图像外将dge赋为1
end
end
end
if dge~=1
B(r1,c1)=A(seed(1),seed(2));
end
if count>=n
top=1;
end
q=q(2:top,:);
top=top-1;
end
subplot(1,2,1),imshow(A,[]); title('待处理图像');
subplot(1,2,2),imshow(B,[]); title('分割结果');




