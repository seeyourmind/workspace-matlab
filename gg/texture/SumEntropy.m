function [ entropy ] = SumEntropy( pn )
%SUMENTROPY 此处显示有关此函数的摘要
%   此处显示详细说明
    sumcols = zeros(1,size(pn,1));
    for i = 1:size(pn,1)
        sumcols(i) = sum(-pn(i,1:end).*log2(pn(i,1:end)+eps));
    end
    entropy = sum(sumcols);
end

