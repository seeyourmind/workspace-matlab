function [ Y ] = KSW( Ii )
%KSW �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    h=imhist(Ii); %�����Ҷ�ֱ��ͼ
    h1=h;
    len=length(h); %������еĿ��ܻҶ�
    [m,n]=size(Ii); %���ͼ��Ĵ�С
    h1=(h1+eps)/(m*n); %������Ҷȵ���ֵĸ���
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

