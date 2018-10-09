function [ entropy ] = SumEntropy( pn )
%SUMENTROPY �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    sumcols = zeros(1,size(pn,1));
    for i = 1:size(pn,1)
        sumcols(i) = sum(-pn(i,1:end).*log2(pn(i,1:end)+eps));
    end
    entropy = sum(sumcols);
end

