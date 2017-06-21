function y=meb(x,a,b,c)
%below is a shape of a triangle
if x <= a
    y=0;
end;
if (x > a) & (x <= b)
    y=(x-a)/(b-a);
end;
if (x > b) & (x <= c)
    y=(c-x)/(c-b);
end;
if x > c
    y=0;
end;

%the right side of a triangle
if a == b
    if x <= b
        y=1;
    end;
    if (x > b) & (x <= c)
        y=(c-x)/(c-b);
    end;
    if x > c
        y=0;
    end;
end;
%the left side of a triangle
if b == c
    if x <= a
        y=0;
    end;
    if (x > a) & (x <= b)
        y=(x-a)/(b-a);
    end;
    if x > b
        y=1;
    end;
end;
