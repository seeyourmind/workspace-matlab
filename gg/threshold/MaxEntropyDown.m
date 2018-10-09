function [ Y,index,result ] = MaxEntropyDown( im )
%MAXENTROPYDOWN ������ͼ����أ��ָ�ƫ�ڵĲ���
%   im:������ͼ�� Y:�ָ��ͼ�� index:����ض�Ӧ�Ҷ� result:�����ֵ
    I=im; %����ͼ��
    I = histeq(I);
    h=imhist(I);          %�����Ҷ�ֱ��ͼ
    h1=h;
    len=length(h);     %������еĿ��ܻҶ�
    [m,n]=size(I);        %���ͼ��Ĵ�С
    total = 0;
    for i=1:m
        for j=1:n
            if I(i,j)<255
                total = total+1;
            end
        end
    end
    
    h1=(h1+eps)/total;            %������Ҷȵ���ֵĸ��� 

    for i=1:(len-2)
        if h(i)~=0
            P1=sum(h1(1:i));
            P2=sum(h1((i+1):len-2));
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
           if Y(a,b)<index;
               Y(a,b)=255;
           end
       end
    end
end