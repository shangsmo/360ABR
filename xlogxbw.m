function [r] = xlogxbw(x,bw)
%XLOGXBW 此处显示有关此函数的摘要
%   此处显示详细说明
r=0;
[m,n]=size(x);
for i=1:m
    for j=1:n
        if x(i,j)==0
            r=r-5/90;
        else
            r=r+x(i,j)*log(x(i,j)*bw);
        end
    end
end
end

