function [ img ] = get255( img )
%GET255 此处显示有关此函数的摘要
%   此处显示详细说明
    [m n c] = size(img);
    if c ~= 1
        error('please input a gray image!');
    end
    for i=1:m
        for j=1:n
            if img(i,j)~=255
                img(i,j)=0;
            end
        end
    end
end

