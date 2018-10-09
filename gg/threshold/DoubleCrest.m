function [ original ] = DoubleCrest( im )
%DOUBLECREST 双峰法
%   im:输入待处理图片 dco:处理后图片
    if im(3)~= 1
        original = rgb2gray(im);
    else
        original = im;
    end
    
    % 阈值选取,按动态均值后的图像选
    hist = imhist(original);
    figure,bar(imhist(original))
    [max0, index0] = max(hist);
    front = hist(1:index0-1);
    back = hist(index0+1:end);
    [max1, index1] = max(front);
    [max2, index2] = max(back);
    if max1 > max2
        x1 = index1;
        x2 = index0;
    else
        x1 = index0;
        x2 = index2;
    end
    if x1 > x2
        temp = x2;
        x2 = x1;
        x1 = temp;
    end
    x1
    x2
    [minv, index] = min(hist(x1:x2));
    index = index+x1;
    index
    [m,n] = size(original);

    for i=1:m
        for j=1:n
            if original(i,j) < 125
                original(i,j) = 255;
            else
                original(i,j) = 0;
            end
        end
    end
end

