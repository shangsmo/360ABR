function [r] = xlogxbw(x,bw)
%XLOGXBW �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
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

