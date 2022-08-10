function [res_bitrate,res_psnr] = abr_GP(bw,weight,bit,psnr,For_psnr)
%ABR_GB 此处显示有关此函数的摘要
%   此处显示详细说明
[Width,Length]=size(weight);
w=zeros([Width*Length,length(bit)]);
for_psnr=zeros([Width*Length,length(bit)]);

for i=1:Length
    for j=1:Width
        for k=1:length(bit)
            w(j+(i-1)*Width,k)=weight(j,i);
            for_psnr(j+(i-1)*Width,k)=For_psnr(j,i);
        end
    end
end

value=w.*(psnr-0.5*abs(psnr-for_psnr));
%value=w.*psnr;
maxValue=zeros([Width*Length,bw]);
g=zeros([Width*Length,bw]);
for tile = 1:Width*Length
    for th=1:bw
        for br = 1:length(bit)
            if th>bit(br)
                if tile==1
                    maxValue(tile,th)=max([maxValue(tile,th),value(tile,br)]);
                    if maxValue(tile,th)==value(tile,br)
                        g(tile,th)=br;
                    end
                else
                    maxValue(tile,th)=max([maxValue(tile,th),maxValue(tile-1,th),maxValue(tile-1,th-bit(br))+value(tile,br)]);
                    if maxValue(tile,th)==maxValue(tile-1,th-bit(br))+value(tile,br)
                        g(tile,th)=br;
                    end
                end
            end
        end
    end
end

bitrate=zeros([1,Width*Length]);
now_psnr=zeros([1,Width*Length]);
v=bw;
t=Width*Length;
while(t>0)
    if g(t,v) == 0
        bitrate(t)=0;
        now_psnr(t)=0;
    else
        bitrate(t)=bit(g(t,v));
        now_psnr(t)=psnr(t,g(t,v));
        v=v-bit(g(t,v));
    end
    t=t-1;
end
res_bitrate=zeros([Width,Length]);
res_psnr=zeros([Width,Length]);
for i=1:Length
    for j=1:Width
        res_bitrate(j,i)=bitrate(j+(i-1)*Width);
        res_psnr(j,i)=now_psnr(j+(i-1)*Width);
    end
end
end

