function [fov] = fovtile(int)
%FOV 高斯积分后分配fov
%   此处显示详细说明
m=size(int);
row=m(1);
col=m(2);
fov=zeros([row,col]);
col_lim=0;
row_lim=0;
for l=1:row
    if (l*pi/row>pi/4)
        row_lim=l;
        break
    end
end

for l=1:col
    if (2*l*pi/row>pi/3)
        col_lim=l;
        break
    end
end

A=[flipud([int,int,int]);[int,int,int];flipud([int,int,int])];

for i=1:row
    for j=1:col
        for m=row+i-row_lim:row+i+row_lim
            for n=col+j-col_lim:col+j+col_lim
                fov(i,j)=fov(i,j)+A(m,n)/((2*row_lim+1)*(2*col_lim+1));
            end
        end
    end
end
    

end

