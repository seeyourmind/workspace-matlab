function [ T ] = Texture( img )
%TEXTURE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    I = imread(img);
    if ndims(I) == 3
        I = rgb2gray(I);
    end

    L = 16;
    %%MTALBA�Դ��������
    P_0=graycomatrix(I, 'NumLevels',L,'Offset',[0 1]);      %0�㷽��
    P_45=graycomatrix(I, 'NumLevels',L,'Offset',[-1 1]);    %45�㷽��
    P_90=graycomatrix(I, 'NumLevels',L,'Offset',[-1 0]);    %90�㷽��
    P_135=graycomatrix(I, 'NumLevels',L,'Offset',[-1 -1]);  %135�㷽��
    a= graycoprops(P_0);
    b= graycoprops(P_45);
    c= graycoprops(P_90);
    d= graycoprops(P_135);
    
    %�������ʣ����ڶ��������������ǿ��Ӧ
    P_0n = P_0/sum(P_0(:));
    P_45n = P_45/sum(P_45(:));
    P_90n = P_90/sum(P_90(:));
    P_135n = P_135/sum(P_135(:));
    a.MaxProbability = max(P_0n(:));
    b.MaxProbability = max(P_45n(:));
    c.MaxProbability = max(P_90n(:));
    d.MaxProbability = max(P_135n(:));
    %�����
    a.Entropy = SumEntropy(P_0n);
    b.Entropy = SumEntropy(P_45n);
    c.Entropy = SumEntropy(P_90n);
    d.Entropy = SumEntropy(P_135n);
    %���������ֵ
    T.Contrast.mean = mean([a.Contrast,b.Contrast,c.Contrast,d.Contrast]);
    T.Correlation.mean = mean([a.Correlation,b.Correlation,c.Correlation,d.Correlation]);
    T.Energy.mean = mean([a.Energy,b.Energy,c.Energy,d.Energy]);
    T.Homogeneity.mean = mean([a.Homogeneity,b.Homogeneity,c.Homogeneity,d.Homogeneity]);
    T.MaxProbability.mean = mean([a.MaxProbability,b.MaxProbability,c.MaxProbability,d.MaxProbability]);
    T.Entropy.mean = mean([a.Entropy,b.Entropy,c.Entropy,d.Entropy]);
    %���������׼��
    T.Contrast.std = std([a.Contrast,b.Contrast,c.Contrast,d.Contrast]);
    T.Correlation.std = std([a.Correlation,b.Correlation,c.Correlation,d.Correlation]);
    T.Energy.std = std([a.Energy,b.Energy,c.Energy,d.Energy]);
    T.Homogeneity.std = std([a.Homogeneity,b.Homogeneity,c.Homogeneity,d.Homogeneity]);
    T.MaxProbability.std = std([a.MaxProbability,b.MaxProbability,c.MaxProbability,d.MaxProbability]);
    T.Entropy.std = std([a.Entropy,b.Entropy,c.Entropy,d.Entropy]);
end

