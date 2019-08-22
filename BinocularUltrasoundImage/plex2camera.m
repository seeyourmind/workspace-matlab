function [ return_coor onePlex ] = plex2camera( xyL, xyR, imgW, imgH )
%PLEX2CAMERA 此处显示有关此函数的摘要
%   此处显示详细说明
    ONEPLEX = 10.0/15.0;
    BASELINE = 6.0;
    FOCUS = 80.0;
    
    return_coor = zeros(size(xyL,1)-1, 4);
    u0 = 1.0*imgW/2;
    v0 = 1.0*imgH/2;
    
    for i=1:size(xyL,1)-1
        delta = ONEPLEX*(xyL(i,2)-xyR(i,2));
        return_coor(i,:) = [ONEPLEX*BASELINE*(xyL(i,1)-u0)/delta, ONEPLEX*BASELINE*(xyL(i,2)-v0)/delta, BASELINE*FOCUS/delta, 1];
    end
    onePlex = (return_coor(1,1)-return_coor(1,2))/(xyL(1,1)-xyL(1,2));

end

