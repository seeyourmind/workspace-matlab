clear;clc;
T0 = Texture('0.png');
T1 = Texture('5-1.png');

M0 = stru2matx(T0);
M1 = stru2matx(T1);

m01 = M0-M1;

mcol1 = m01(:,1);
mcol2 = m01(:,2);
%求均值列为正数据的个数和位置
count1 = 0;
for i=1:size(mcol1)
    if mcol1(i)>=0
        count1 = count1+1;
    end
end
position1 = find(mcol1>=0);
%求标准差列为正数据的个数和位置
count2 = 0;
for i=1:size(mcol2)
    if mcol2(i)>=0
        count2 = count2+1;
    end
end
position2 = find(mcol2>=0);
%判断
switch count1
    case 0
        T1.Result = '划痕';
    case 1
        T1.Result = '辊印';
    case 2
        if count2 == 5
            T1.Result = '粘结';
        elseif max(mcol1) < 0.15
            T1.Result = '折痕';
        elseif max(mcol1)>0.15&&max(mcol1)<0.35
            T1.Result = '气泡';
        else
            T1.Result = '氧化';
        end
    case 3
        if count2 == 6
            T1.Result = '结疤';
        else
            T1.Result = '压痕';
        end
end
T1.Result
        
 



