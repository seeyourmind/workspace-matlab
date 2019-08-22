function [ img ] = get255( img )
%GET255 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
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

