function [ J ] = GrayTransform( im )
%GRAYTRANSFORM �Ҷȱ任
%   im:ԭͼ�� J:uint8����ת����ͼ��
    I = imread(im);
    h = imhist(rgb2gray(I));
    [maxv,hmax] = max(h);
    [minv,hmin] = min(h);
    c = hmax*0.6;
    I = double(I);
    J = (I-c)*255/hmax;
    row = size(I,1);
    column = size(I,2);
    for i = 1:row
        for j = 1:column
            if J(i,j)<0
                J(i,j) = 0;
            end
            if J(i,j)>255
                J(i,j) = 255;
            end
        end
    end
    J = uint8(J);
end