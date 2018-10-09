function [ M ] = stru2matx( S )
%STRU2MATX 此处显示有关此函数的摘要
%   此处显示详细说明
    M = zeros(6,2);
    M(1,1) = S.Contrast.mean;
    M(1,2) = S.Contrast.std;
    M(2,1) = S.Correlation.mean;
    M(2,2) = S.Correlation.std;
    M(3,1) = S.Energy.mean;
    M(3,2) = S.Energy.std;
    M(4,1) = S.Homogeneity.mean;
    M(4,2) = S.Homogeneity.std;
    M(5,1) = S.MaxProbability.mean;
    M(5,2) = S.MaxProbability.std;
    M(6,1) = S.Entropy.mean;
    M(6,2) = S.Entropy.std;
end

