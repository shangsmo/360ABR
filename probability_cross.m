function [probability] = probability_cross(viewpoint)
%PROBABILITY_CROSS 将多用户的视点转化为某一时刻的概率
%   此处显示详细说明
probability=zeros([6,12]);
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
    probability(x,y)=probability(x,y)+1;
end
probability=probability/sum(sum(probability));
end

