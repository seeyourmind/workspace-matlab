clear;clc;
%{
figure;
im=imread('1.png'); %�ļ���Ϊ1.jpg��ͼ�񣬷���c�̵��£���Ȼ·���������Լ���
if size(im,3)>1  %�ж�����ǲ�ɫͼ��ת��Ϊ�Ҷ�ͼ
    im=im(:,:,2);
end
hist_im=imhist(im); %����ֱ��ͼ
subplot(241);
xlabel('��ӡ');
plot(hist_im);%��ֱ��ͼ  
%%%
im=imread('2.png'); %�ļ���Ϊ1.jpg��ͼ�񣬷���c�̵��£���Ȼ·���������Լ���
if size(im,3)>1  %�ж�����ǲ�ɫͼ��ת��Ϊ�Ҷ�ͼ
    im=im(:,:,2);
end
hist_im=imhist(im); %����ֱ��ͼ
subplot(242);
xlabel('ճ��');
plot(hist_im);%��ֱ��ͼ
%%%
im=imread('3.png'); %�ļ���Ϊ1.jpg��ͼ�񣬷���c�̵��£���Ȼ·���������Լ���
if size(im,3)>1  %�ж�����ǲ�ɫͼ��ת��Ϊ�Ҷ�ͼ
    im=im(:,:,2);
end
hist_im=imhist(im); %����ֱ��ͼ
subplot(243);
xlabel('ѹ��');
plot(hist_im);%��ֱ��ͼ
%%%
im=imread('4.png'); %�ļ���Ϊ1.jpg��ͼ�񣬷���c�̵��£���Ȼ·���������Լ���
if size(im,3)>1  %�ж�����ǲ�ɫͼ��ת��Ϊ�Ҷ�ͼ
    im=im(:,:,2);
end
hist_im=imhist(im); %����ֱ��ͼ
subplot(244);
xlabel('�ۺ�');
plot(hist_im);%��ֱ��ͼ
%%%
im=imread('5.png'); %�ļ���Ϊ1.jpg��ͼ�񣬷���c�̵��£���Ȼ·���������Լ���
if size(im,3)>1  %�ж�����ǲ�ɫͼ��ת��Ϊ�Ҷ�ͼ
    im=im(:,:,2);
end
hist_im=imhist(im); %����ֱ��ͼ
subplot(245);
xlabel('���');
plot(hist_im);%��ֱ��ͼ
%%%
im=imread('6.png'); %�ļ���Ϊ1.jpg��ͼ�񣬷���c�̵��£���Ȼ·���������Լ���
if size(im,3)>1  %�ж�����ǲ�ɫͼ��ת��Ϊ�Ҷ�ͼ
    im=im(:,:,2);
end
hist_im=imhist(im); %����ֱ��ͼ
subplot(246);
xlabel('����');
plot(hist_im);%��ֱ��ͼ
%%%
im=imread('7.png'); %�ļ���Ϊ1.jpg��ͼ�񣬷���c�̵��£���Ȼ·���������Լ���
if size(im,3)>1  %�ж�����ǲ�ɫͼ��ת��Ϊ�Ҷ�ͼ
    im=im(:,:,2);
end
hist_im=imhist(im); %����ֱ��ͼ
subplot(247);
xlabel('����');
plot(hist_im);%��ֱ��ͼ
%%%
im=imread('8.png'); %�ļ���Ϊ1.jpg��ͼ�񣬷���c�̵��£���Ȼ·���������Լ���
if size(im,3)>1  %�ж�����ǲ�ɫͼ��ת��Ϊ�Ҷ�ͼ
    im=im(:,:,2);
end
hist_im=imhist(im); %����ֱ��ͼ
subplot(248);
xlabel('����');
plot(hist_im);%��ֱ��ͼ
figure;
im=imread('1.png'); %�ļ���Ϊ1.jpg��ͼ�񣬷���c�̵��£���Ȼ·���������Լ���
im=DynamicMean(im);
hist_im=imhist(im); %����ֱ��ͼ
subplot(241);
xlabel('��ӡ');
plot(hist_im);%��ֱ��ͼ  
%%%
im=imread('2.png'); %�ļ���Ϊ1.jpg��ͼ�񣬷���c�̵��£���Ȼ·���������Լ���
im=DynamicMean(im);
hist_im=imhist(im); %����ֱ��ͼ
subplot(242);
xlabel('ճ��');
plot(hist_im);%��ֱ��ͼ
%%%
im=imread('3.png'); %�ļ���Ϊ1.jpg��ͼ�񣬷���c�̵��£���Ȼ·���������Լ���
im=DynamicMean(im);
hist_im=imhist(im); %����ֱ��ͼ
subplot(243);
xlabel('ѹ��');
plot(hist_im);%��ֱ��ͼ
%%%
im=imread('4.png'); %�ļ���Ϊ1.jpg��ͼ�񣬷���c�̵��£���Ȼ·���������Լ���
im=DynamicMean(im);
hist_im=imhist(im); %����ֱ��ͼ
subplot(244);
xlabel('�ۺ�');
plot(hist_im);%��ֱ��ͼ
%%%
im=imread('5.png'); %�ļ���Ϊ1.jpg��ͼ�񣬷���c�̵��£���Ȼ·���������Լ���
im=DynamicMean(im);
hist_im=imhist(im); %����ֱ��ͼ
subplot(245);
xlabel('���');
plot(hist_im);%��ֱ��ͼ
%%%
im=imread('6.png'); %�ļ���Ϊ1.jpg��ͼ�񣬷���c�̵��£���Ȼ·���������Լ���
im=DynamicMean(im);
hist_im=imhist(im); %����ֱ��ͼ
subplot(246);
xlabel('����');
plot(hist_im);%��ֱ��ͼ
%%%
im=imread('7.png'); %�ļ���Ϊ1.jpg��ͼ�񣬷���c�̵��£���Ȼ·���������Լ���
im=DynamicMean(im);
hist_im=imhist(im); %����ֱ��ͼ
subplot(247);
xlabel('����');
plot(hist_im);%��ֱ��ͼ
%%%
im=imread('8.png'); %�ļ���Ϊ1.jpg��ͼ�񣬷���c�̵��£���Ȼ·���������Լ���
im=DynamicMean(im);
hist_im=imhist(im); %����ֱ��ͼ
subplot(248);
xlabel('����');
plot(hist_im);%��ֱ��ͼ
%}
im=imread('../image/2.png'); %�ļ���Ϊ1.jpg��ͼ�񣬷���c�̵��£���Ȼ·���������Լ���
im=DynamicMean(im);
h=entropy(im);
hist_im=imhist(im); %����ֱ��ͼ
plot(hist_im);%��ֱ��ͼ

A0=imread('../image/2.png');  %����ͼ��
seed=[100,220];         %ѡ����ʼλ��
thresh=16;             %������ѡ����ֵ
A=rgb2gray(A0); %�ҶȻ�
A=imadjust(A,[min(min(double(A)))/255,max(max(double(A)))/255],[]);
A=double(A);          
B=A;                 
[r,c]=size(B);            %ͼ��ߴ� rΪ������cΪ����
n=r*c;                 %����ͼ����������ĸ���
pixel_seed=A(seed(1),seed(2)); 
q=[seed(1) seed(2)];      %q����װ����ʼλ��
top=1;                 
M=zeros(r,c);            %����һ����ԭͼ��ͬ�ȴ�С�ľ���
M(seed(1),seed(2))=1;     %����ʼ�㸳Ϊ1������Ϊ0
count=1;       %������
while top~=0    %ѭ����������
r1=q(1,1);      %��ʼ����λ��
c1=q(1,2);      %��ʼ����λ��
p=A(r1,c1);     %��ʼ��Ҷ�ֵ
dge=0;
for i=-1:1 
for j=-1:1
if r1+i<=r && r1+i>0 && c1+j<=c && c1+j>0 
if abs(A(r1+i,c1+j)-p)<=thresh && M(r1+i,c1+j)~=1
top=top+1; 
q(top,:)=[r1+i c1+j];%�������ж���������Χ���λ�ø���q��q�����������ж���ÿһ���
M(r1+i,c1+j)=1;  %�����ж�������M�����Ӧ�ĵ㸳Ϊ1
count=count+1;  %ͳ�������ж������ĵ��������ʵ��top��ʱ��ֵһ��
B(r1+i,c1+j)=1;   %�����ж�������B�����Ӧ�ĵ㸳Ϊ1
end
if M(r1+i,c1+j)==0; 
dge=1;          %��dge��Ϊ1
end
else
dge=1;          %����ͼ���⽫dge��Ϊ1
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
subplot(1,2,1),imshow(A,[]); title('������ͼ��');
subplot(1,2,2),imshow(B,[]); title('�ָ���');




