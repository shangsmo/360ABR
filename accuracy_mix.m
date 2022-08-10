function [w,accuracy,p] = accuracy_mix(data_all,user,time,interval)
%ACCURACY_MIX 此处显示有关此函数的摘要
%   此处显示详细说明
accuracy=0;
[w,probability]=probability_mix(data_all,user,time,interval);

data_pt=Pretreatment(data_all,time+interval);
viewpoint=data_pt(:,:,user);
p=zeros([length(viewpoint),1]);
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
    p(i)=probability(x,y);
    if probability(x,y)>=0.1
        accuracy=accuracy+1/length(viewpoint);
    end
end
end

