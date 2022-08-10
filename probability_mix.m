function [w,probability] = probability_mix(data_all,user,time,interval)
%PROBABILITY_MIX 此处显示有关此函数的摘要
%   此处显示详细说明
data_pt=Pretreatment(data_all,time+interval);
data_pt_now=Pretreatment(data_all,time);

data_pt_1s=[0,0];
for users=1:45
    data_pt_1s=[data_pt_1s;[data_pt(:,1,users),data_pt(:,2,users)]];
end
data_pt_1s=data_pt_1s(2:length(data_pt_1s),:);

probability_k=probability_kal(data_all,user,time,interval);
probability_c=probability_cross(data_pt_1s);



data_pt_1s_now=[0,0];
for users=1:45
    data_pt_1s_now=[data_pt_1s_now;[data_pt_now(:,1,users),data_pt_now(:,2,users)]];
end
data_pt_1s_now=data_pt_1s_now(2:length(data_pt_1s_now),:);

probability_k_now=probability_kal(data_all,user,time,interval);
probability_c_now=probability_cross(data_pt_1s_now);

viewpoint=data_pt_now(:,:,user);
f=ones([1,1001]);
for j=1:1001
    f(j)=0;
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
        f(j)=f(j)+log(((j-1)*probability_k_now(x,y)+(1001-j)*probability_c_now(x,y))/1000);
    end
end
[~,w]=max(f);
w=(w-1)/1000;
probability=w*probability_k+(1-w)*probability_c;
%probability=probability_k;
end

