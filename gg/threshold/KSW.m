function [ Y ] = KSW( Ii )
%KSW 此处显示有关此函数的摘要
%   此处显示详细说明
    h=imhist(Ii); %画出灰度直方图
    h1=h;
    len=length(h); %求出所有的可能灰度
    [m,n]=size(Ii); %求出图像的大小
    h1=(h1+eps)/(m*n); %算出各灰度点出现的概率
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
    m1=max(H);
    F=find(H==m1);
    Y=Ii;
    for a=1:m;
        for b=1:n;
            if Y(a,b)>=F;
                Y(a,b)=0;
            end
        end
    end
end

