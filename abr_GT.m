function [bitrate] = abr_GT(bw,weight)
%ABR 此处显示有关此函数的摘要
%   此处显示详细说明

level=[0.00001,20,50,100,150,250];
L=length(level);
bitrate=bw * weight;
[I,J]=size(weight);
for i=1:I
    for j=1:J
        for l=2:L
            if bitrate(i,j)>=level(L)
                bitrate(i,j)=level(L);
            elseif bitrate(i,j)<level(l)
                bitrate(i,j)=level(l-1);
                break
            end
        end
    end
end
while(bw-sum(sum(bitrate))>0)
    rbw=bw-sum(sum(bitrate));
    reward=zeros([I,J]);
    for i=1:I
        for j=1:J
            l=find(level==bitrate(i,j));
            if l~=L&&rbw>=level(l+1)-level(l)
                reward(i,j)=weight(i,j)*(log10(level(l+1))-log10(level(l)))/(level(l+1)-level(l));
            else
                reward(i,j)=0;
            end
        end
    end
    if sum(sum(reward))==0
        break
    else
        [x,y]=find(reward==max(max(reward)));
        i=x(round(length(x)/2));
        j=y(round(length(y)/2));
        l=find(level==bitrate(i,j));
        bitrate(i,j)=level(l+1);
    end
end
for i=1:I
    for j=1:J
        if bitrate(i,j)==0
            bitrate(i,j)=level(1);
        end
    end
end

end

