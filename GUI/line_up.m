function labels=line_up(labels,p1,p2)

labels(p1(1),p1(2))=1;
labels(p2(1),p2(2))=1;

p=(p2-p1);
pp=abs(p);
if pp(1)>pp(2)
    if p2(1)>p1(1)
        step=1;
    else
        step=-1;
    end
    for x=p1(1)+step:step:p2(1)-step
        y=p1(2)+round((x-p1(1))*p(2)/p(1));
        labels(x,y)=1;
    end
else
    if p2(2)>p1(2)
        step=1;
    else
        step=-1;
    end
    for y=p1(2)+step:step:p2(2)-step
        x=p1(1)+round((y-p1(2))*p(1)/p(2));
        labels(x,y)=1;
    end
end
