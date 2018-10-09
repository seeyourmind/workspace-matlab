clear;clc;
T0 = Texture('0.png');
T1 = Texture('5-1.png');

M0 = stru2matx(T0);
M1 = stru2matx(T1);

m01 = M0-M1;

mcol1 = m01(:,1);
mcol2 = m01(:,2);
%���ֵ��Ϊ�����ݵĸ�����λ��
count1 = 0;
for i=1:size(mcol1)
    if mcol1(i)>=0
        count1 = count1+1;
    end
end
position1 = find(mcol1>=0);
%���׼����Ϊ�����ݵĸ�����λ��
count2 = 0;
for i=1:size(mcol2)
    if mcol2(i)>=0
        count2 = count2+1;
    end
end
position2 = find(mcol2>=0);
%�ж�
switch count1
    case 0
        T1.Result = '����';
    case 1
        T1.Result = '��ӡ';
    case 2
        if count2 == 5
            T1.Result = 'ճ��';
        elseif max(mcol1) < 0.15
            T1.Result = '�ۺ�';
        elseif max(mcol1)>0.15&&max(mcol1)<0.35
            T1.Result = '����';
        else
            T1.Result = '����';
        end
    case 3
        if count2 == 6
            T1.Result = '���';
        else
            T1.Result = 'ѹ��';
        end
end
T1.Result
        
 



