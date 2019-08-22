function [ igc ] = probe( img )
%PROBE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    if(size(img,3)~=3)
        error('please input a RGB color image!');
        %exit;
    end
    imgR = img(:,:,1);
    imgG = img(:,:,2);
    imgB = img(:,:,3);
    igR = get255(imgR);
    igG = get255(imgG);
    igB = get255(imgB);
    igc = getcombine255(igG, igR, igB);
end

