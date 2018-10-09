I=imread('0.png');I=rgb2gray(I);imshow(I);
disp(I);
I=imresize(I,1/40);
[M,N]=size(I);
for i=1:M
    for j=1:N
        for n=1:16
            if(n-1)*16<=I(i,j)&I(i,j)<=(n-1)*16+15
                I(i,j)=n-1;
            end
        end
    end
end
P=zeros(16,16,4);
for m=1:16
    for n=1:16
        for i=1:M
            for j=1:N
                if j<N & I(i,j)==m-1 & I(i,j+1)==n-1
                    P(m,n,1)=P(m,n,1)+1;
                end
                if i>1&j<N&I(i,j)==m-1 & I(i-1,j+1)==n-1
                    P(m,n,2)=P(m,n,2)+1;
                end
                if i<M & I(i,j)==m-1 & I(i+1,j)==n-1
                    P(m,n,3)=P(m,n,3)+1;
                end
                if i<M &j<N & I(i,j)==m-1 & I(i+1,j+1)==n-1
                    P(m,n,4)=P(m,n,4)+1;
                end
            end
        end
    end
end
for n=1:4
    P(:,:,n)=P(:,:,n)/sum(sum(P(:,:,n)));
end
H=zeros(1,4);
CON=H;
Ux=H;Uy=H;
deltaX=H; deltaY=H;
COR=H;
L=H;
for n=1:4
    ASM(n)=sum(sum(P(:,:,n).^2));
    for i=1:16
        for j=1:16
            if P(i,j,n)~=0
                H(n)=-P(i,j,n)*log(P(i,j,n))+H(n);
            end
            CON(n)=(i-j)^2*P(i,j,n)+CON(n);
            Ux(n)=i*P(i,j,n)+Ux(n);
            Uy(n)=j*P(i,j,n)+Ux(n);
        end
    end
end
for n=1:4
    for i=1:16
        for j=1:16
            deltaX(n)=(i-Ux(n))^2*P(i,j,n)+deltaX(n);
            deltaY(n)=(j-Uy(n))^2*P(i,j,n)+deltaY(n);
            COR(n)=i*j*P(i,j,n)+COR(n);
            L(n)=P(i,j,n)^2/(1+(i-j)^2)+L(n);
        end
    end
    COR(n)=(COR(n)-Ux(n)*Uy(n))/deltaX(n)/deltaY(n);
end
sprintf('0,45,90,135 方向上的能量依次为： %f,%f,%f,%f',ASM(1),ASM(2),ASM(3),ASM(4))
sprintf('0,45,90,135 方向上的熵依次为： %f,%f,%f,%f',H(1),H(2),H(3),H(4))
sprintf('0,45,90,135 方向上的惯性矩依次为： %f,%f,%f,%f',CON(1),CON(2),CON(3),CON(4))
sprintf('0,45,90,135 方向上的相关性依次为： %f,%f,%f,%f',COR(1),COR(2),COR(3),COR(4))
sprintf('0,45,90,135 方向上的逆差距依次为： %f,%f,%f,%f',L(1),L(2),L(3),L(4))
a1=mean(ASM);b1=sqrt(cov(ASM));
a2=mean(H);b2=sqrt(cov(H));
a3=mean(CON);b3=sqrt(cov(CON));
a4=mean(COR);b4=sqrt(cov(COR));
a5=mean(L);b5=sqrt(cov(L));
sprintf('能量的均值和标准差分别为： %f,%f',a1,b1)
sprintf('熵的均值和标准差分别为： %f,%f',a2,b2)
sprintf('惯性矩的均值和标准差分别为： %f,%f',a3,b3)
sprintf('相关性的均值和标准差分别为： %f,%f',a4,b4)
sprintf('逆差距的均值和标准差分别为： %f,%f',a5,b5)