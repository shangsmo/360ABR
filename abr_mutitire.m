function [bitrate] = abr_mutitire(bw,weight,r)
%ABR_MUTITIRE 此处显示有关此函数的摘要
%   此处显示详细说明
[I,J]=size(weight);
%fovtilenum=0;
%for i=1:I
%    for j=1:J
%        if weight(i,j)>=0.1/15
%            fovtilenum=fovtilenum+1;
%        end
%    end
%end
%bata=((1-r)/r)*fovtilenum/(I*J-fovtilenum);

bw_e=bw*r;
bw_b=bw-bw_e;
bitrate_e=abr_mean(bw_e,weight);
weight=ones([I,J]);
bitrate_b=abr_mean(bw_b,weight);
bitrate=max(bitrate_e,bitrate_b);
for i=1:I
    for j=1:J
        if bitrate(i,j)==0
            bitrate(i,j)=level(1);
        end
    end
end
end

