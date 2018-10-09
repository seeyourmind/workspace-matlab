function [ Ii ] = DynamicMean( im )
%DYNAMICMEAN ��̬��ֵ�����������Ӱ��
%   input:������ͼƬ output:�����ͼƬ
    [x,y,z] = size(im);
    if z~=1
        im = rgb2gray(im);
    else
        im = im;
    end

    [m,n] = size(im);
    I = double(im);% ����ת����double���������ſ���������
    R = zeros(m,n);% ��¼�лҶ�ֵ
    C = zeros(m,n);% ��¼�лҶ�ֵ
    Rmean = zeros(m,1);% ��¼�о�ֵ
    Cmean = zeros(1,n);% ��¼�о�ֵ
    % �����о�ֵ
    for i = 1:m
        for j = 1:n
            Rmean(i) = Rmean(i) + I(i,j);
        end
        Rmean(i) = Rmean(i)/n;
    end
    % �����о�ֵ
    for i = 1:n
        for j = 1:m
            Cmean(i) = Cmean(i) + I(j,i);
        end
        Cmean(i) = Cmean(i)/m;
    end
    % ������ֵ
    DR = zeros(m,1);% ��¼����ֵ
    DC = zeros(1,n);% ��¼����ֵ
    bcyz = 0.2;% ��������
    for i = 1:m
        DR(i) = Rmean(i) + bcyz*(max(I(i,:)) - Rmean(i));
    end
    for i = 1:n
        DC(i) = Cmean(i) + bcyz*(max(I(:,i)) - Cmean(i));
    end
    % ���㰵�ҶȾ�ֵ
    DRdarkmean = zeros(m,1);% ��¼�а��ҶȾ�ֵ
    DCdarkmean = zeros(1,n);% ��¼�а��ҶȾ�ֵ
    for i = 1:m
        p = 0;
        for j = 1:n
            if I(i,j) <= DR(i)
                DRdarkmean(i) = DRdarkmean(i) + I(i,j);
                p = p+1;
            end
        end
        DRdarkmean(i) = DRdarkmean(i)/p;
    end
    for i = 1:n
        p = 0;
        for j = 1:m
            if I(j,i) <= DC(i)
                DCdarkmean(i) = DCdarkmean(i) + I(j,i);
                p = p+1;
            end
        end
        DCdarkmean(i) = DCdarkmean(i)/p;
    end
    % ���㰴��ֵ�ָ�ĻҶ�ֵ
    for i = 1:m
        for j = 1:n
            if I(i,j) < DR(i)
                R(i,j) = I(i,j);
            else
                R(i,j) = DRdarkmean(i);
            end
        end
    end
    for j = 1:n
        for i = 1:m
            if I(i,j) < DC(j)
                C(i,j) = I(i,j);
            else
                C(i,j) = DCdarkmean(j);
            end
        end
    end
    % ��̬��ֵ�����Ҷ�ֵ
    Ii = (R+C)/2;
    Ii = uint8(Ii);
end

