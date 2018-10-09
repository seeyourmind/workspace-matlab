%add point hardconstrains
%input: labels, A
%output: labels

function labels=add_constrain(labels,A)

image_size=size(labels);
if labels(A(1),A(2))==1 %A is a middle point between the inner and outer boundary
   min_A=inf;
   min_B=inf;
    for i=1:image_size(1)
        for j=1:image_size(2)
            if labels(i,j)==2
                dist1=[A(1)-i A(2)-j]*[A(1)-i; A(2)-j];
                if dist1<min_A
                    min_A=dist1;
                    sa=[i;j];
                end
             end
             if labels(i,j)==3
                dist2=[A(1)-i A(2)-j]*[A(1)-i; A(2)-j];
                if dist2<min_B
                   min_B=dist2;
                   sb=[i;j];
                end
             end
             
        end
    end
    label_a=line_up(0&labels,A,sa);
    label_a(sa(1),sa(2))=0;
    label_b=line_up(0&labels,A,sb);
    label_b(sb(1),sb(2))=0;
    labels=int8(double(labels)+double(label_a)+double(label_b)*2);
    labels(A(1),A(2))=1;
    
 elseif labels(A(1),A(2))==2
    min_A=inf;
    for i=1:image_size(1)
        for j=1:image_size(2)
            if labels(i,j)==3
                dist=[A(1)-i A(2)-j]*[A(1)-i; A(2)-j];
                if dist<min_A
                    min_A=dist;
                    sa=[i;j];
                end
             end
        end
     end
     label_a=line_up(0&labels, A, sa);
     label_a(A(1),A(2))=0;
     labels=int8(double(labels)+2*double(label_a));

 elseif labels(A(1),A(2))==3
    label_AB=0&labels;
    label_AB(A(1),A(2))=1;
    label_AB_w=imdilate(label_AB,[1 1 1;1 1 1;1 1 1]) & ~label_AB;
    
    min_C=inf;
    for i=1:image_size(1)
        for j=1:image_size(2)
            if labels(i,j)==2
                dist=[A(1)-i A(2)-j]*[A(1)-i; A(2)-j];
                if dist<min_C
                    min_C=dist;
                    C=[i;j];
                end
            end
        end
    end
    label_BC=line_up(0&labels,A,C);
    label_BC(C(1),C(2))=0;
    
    label_3=label_AB_w | labels==3;
    label_2=label_AB|label_BC|labels==2;
    label_3=label_3 & ~label_2;
    label_1=labels==1;
    label_1=label_1 & ~label_2 &~label_3;
    labels=int8(double(label_1)+2*double(label_2)+3*double(label_3));
    
elseif labels(A(1),A(2))==0
    label_bw=labels>0;
    label_bw=bwfill(label_bw,1,1,8);
    if label_bw(A(1),A(2))==1
        min_B=inf;
        for i=1:image_size(1)
            for j=1:image_size(2)
                if labels(i,j)==3
                    dist=[A(1)-i A(2)-j]*[A(1)-i; A(2)-j];
                    if dist<min_B
                        min_B=dist;
                        B=[i;j];
                    end
                end
            end
        end
        label_AB=line_up(0&labels,A,B);
        label_AB(B(1),B(2))=0;
        label_AB_w=imdilate(label_AB,[1 1 1;1 1 1;1 1 1]) & ~label_AB;

        min_C=inf;
        for i=1:image_size(1)
            for j=1:image_size(2)
                if labels(i,j)==2
                    dist=[B(1)-i B(2)-j]*[B(1)-i; B(2)-j];
                    if dist<min_C
                        min_C=dist;
                        C=[i;j];
                    end
                end
            end
        end
        label_BC=line_up(0&labels,B,C);
        label_BC(C(1),C(2))=0;

        label_3=label_AB_w | labels==3;
        label_2=label_AB|label_BC|labels==2;
        label_3=label_3 & ~label_2;
        label_1=labels==1;
        label_1=label_1 & ~label_2 &~label_3;
        labels=int8(double(label_1)+2*double(label_2)+3*double(label_3));
    else
        min_B=inf;
        for i=1:image_size(1)
            for j=1:image_size(2)
                if labels(i,j)==2
                    dist=[A(1)-i A(2)-j]*[A(1)-i; A(2)-j];
                    if dist<min_B
                        min_B=dist;
                        B=[i;j];
                    end
                end
            end
        end
        label_AB=line_up(0&labels,A,B);
        label_AB(B(1),B(2))=0;
        label_AB_w=imdilate(label_AB,[1 1 1;1 1 1;1 1 1]) & ~label_AB;

        min_C=inf;
        for i=1:image_size(1)
            for j=1:image_size(2)
                if labels(i,j)==3
                    dist=[B(1)-i B(2)-j]*[B(1)-i; B(2)-j];
                    if dist<min_C
                        min_C=dist;
                        C=[i;j];
                    end
                end
            end
        end
        label_BC=line_up(0&labels,B,C);
        label_BC(C(1),C(2))=0;

        label_2=label_AB_w | labels==2;
        label_3=label_AB|label_BC|labels==3;
        label_2=label_2 & ~label_3;
        label_1=labels==1;
        label_1=label_1 & ~label_2 &~label_3;
        labels=int8(double(label_1)+2*double(label_2)+3*double(label_3));
    end
end