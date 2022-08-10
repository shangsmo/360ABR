function [bitrate] = abr_mean(bw,weight)
%ABR_MEAN 此处显示有关此函数的摘要
level=[0.00001,10,20,50,100,150,250];
L=length(level);
[I,J]=size(weight);
for i=1:I
    for j=1:J
        if weight(i,j)>=0.1/15
            weight(i,j)=1;
        else
            weight(i,j)=0;
        end
    end
end
tilenum=sum(sum(weight));
for i=1:I
    for j=1:J
        for l=2:L
            if level(L)*tilenum<=bw
                rate=level(L);
            elseif level(l)*tilenum>bw
                rate=level(l-1);
                break
            end
        end
    end
end
bitrate=weight*rate;
for i=1:I
    for j=1:J
        if bitrate(i,j)==0
            bitrate(i,j)=level(1);
        end
    end
end
end

