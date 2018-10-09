function [ Y,index,result ] = MaxEntropy( im )
%MAXENTROPY 求输入图像的熵  
%   im:待求熵图像 Y:分割后图像 index:最大熵对应灰度 result:最大熵值
    I=rgb2gray(im); %读入图像
    I = histeq(I);
    h=imhist(I);          %画出灰度直方图
    h1=h;
    len=length(h);     %求出所有的可能灰度
    [m,n]=size(I);        %求出图像的大小
    h1=(h1+eps)/(m*n);            %算出各灰度点出现的概率 

    for i=1:(len-1)
        if h(i)~=0
            P1=sum(h1(1:i));
            P2=sum(h1((i+1):len));
        else 
            continue;
        end
        H1(i)=-(sum(P1.*log(P1)));
        H2(i)=-(sum(P2.*log(P2)));
        H(i)=H1(i)+H2(i);
    end

    result=max(H);
    index=find(H==result);
    Y=I;
    for a=1:m;
       for b=1:n;
           if Y(a,b)>=index;
               Y(a,b)=0;
           else
               Y(a,b)=255;
           end
       end
    end
end