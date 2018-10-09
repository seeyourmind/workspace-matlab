function [ Ii ] = DynamicMean( im )
%DYNAMICMEAN 动态均值法，避免光照影响
%   input:待处理图片 output:处理后图片
    [x,y,z] = size(im);
    if z~=1
        im = rgb2gray(im);
    else
        im = im;
    end

    [m,n] = size(im);
    I = double(im);% 必须转换成double类型这样才可以做运算
    R = zeros(m,n);% 记录行灰度值
    C = zeros(m,n);% 记录列灰度值
    Rmean = zeros(m,1);% 记录行均值
    Cmean = zeros(1,n);% 记录列均值
    % 计算行均值
    for i = 1:m
        for j = 1:n
            Rmean(i) = Rmean(i) + I(i,j);
        end
        Rmean(i) = Rmean(i)/n;
    end
    % 计算列均值
    for i = 1:n
        for j = 1:m
            Cmean(i) = Cmean(i) + I(j,i);
        end
        Cmean(i) = Cmean(i)/m;
    end
    % 计算阈值
    DR = zeros(m,1);% 记录行阈值
    DC = zeros(1,n);% 记录列阈值
    bcyz = 0.2;% 补偿因子
    for i = 1:m
        DR(i) = Rmean(i) + bcyz*(max(I(i,:)) - Rmean(i));
    end
    for i = 1:n
        DC(i) = Cmean(i) + bcyz*(max(I(:,i)) - Cmean(i));
    end
    % 计算暗灰度均值
    DRdarkmean = zeros(m,1);% 记录行暗灰度均值
    DCdarkmean = zeros(1,n);% 记录列暗灰度均值
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
    % 计算按阈值分割的灰度值
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
    % 动态均值处理后灰度值
    Ii = (R+C)/2;
    Ii = uint8(Ii);
end

