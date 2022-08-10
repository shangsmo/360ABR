function [fov] = fovweight(data_all,user,time)
%FOVWEIGHT time时刻真实的权重
%   此处显示详细说明
p=zeros([6,12]);
data_pt=Pretreatment(data_all,time);
viewpoint=data_pt(:,:,user);
for i=1:length(viewpoint)
    if viewpoint(i,2)<=pi/2 && viewpoint(i,2)>pi/3
        x=1;
    elseif viewpoint(i,2)<=pi/3 && viewpoint(i,2)>pi/6
        x=2;
    elseif viewpoint(i,2)<=pi/6 && viewpoint(i,2)>0
        x=3;
    elseif viewpoint(i,2)<=0 && viewpoint(i,2)>-pi/6
        x=4;
    elseif viewpoint(i,2)<=-pi/6 && viewpoint(i,2)>-pi/3
        x=5;        
    else
        x=6;
    end
    
    if viewpoint(i,1)>=0 && viewpoint(i,1)<pi/6
        y=1;
    elseif viewpoint(i,1)>=pi/6 && viewpoint(i,1)<pi/3
        y=2;
    elseif viewpoint(i,1)>=pi/3 && viewpoint(i,1)<pi/2
        y=3;
    elseif viewpoint(i,1)>=pi/2 && viewpoint(i,1)<2*pi/3
        y=4;
    elseif viewpoint(i,1)>=2*pi/3 && viewpoint(i,1)<5*pi/6
        y=5;
    elseif viewpoint(i,1)>=5*pi/6 && viewpoint(i,1)<pi
        y=6;
    elseif viewpoint(i,1)>=pi && viewpoint(i,1)<7*pi/6
        y=7;
    elseif viewpoint(i,1)>=7*pi/6 && viewpoint(i,1)<4*pi/3
        y=8;
    elseif viewpoint(i,1)>=4*pi/3 && viewpoint(i,1)<3*pi/2
        y=9;
    elseif viewpoint(i,1)>=3*pi/2 && viewpoint(i,1)<5*pi/3
        y=10;
    elseif viewpoint(i,1)>=5*pi/3 && viewpoint(i,1)<11*pi/6
        y=11;
    else
        y=12;
    end
    p(x,y)=p(x,y)+1/length(viewpoint);
end
fov=fovtile(p);
end

