function [probability] = probability_kal(data_all,user,time,interval)
%PROBABILITY_KAL 此处显示有关此函数的摘要
%   此处显示详细说明
global errorsigma
viewpoint=Pretreatment(data_all,time-interval);
viewpoint_pre=viewpoint(:,:,user);
prodiction_pre=zeros(size(viewpoint_pre));
i=(1:length(viewpoint_pre)).';
px=polyfit(i,viewpoint_pre(:,1),1);
py=polyfit(i,viewpoint_pre(:,2),1);
for i=1:length(viewpoint_pre)
    prodiction_pre(i,1)=px(1)*(interval*length(viewpoint_pre)+i)+px(2);
    prodiction_pre(i,2)=py(1)*(interval*length(viewpoint_pre)+i)+py(2);
end
prodiction_pre_mean=mean(prodiction_pre);
while(prodiction_pre_mean(1)>2*pi)
    prodiction_pre_mean(1)=prodiction_pre_mean(1)-2*pi;
end
while(prodiction_pre_mean(1)<0)
    prodiction_pre_mean(1)=prodiction_pre_mean(1)+2*pi;
end
while(prodiction_pre_mean(2)>pi/2||prodiction_pre_mean(2)<-pi/2)
    if prodiction_pre_mean(2)>pi/2
        prodiction_pre_mean(2)=pi-prodiction_pre_mean(2);
    end
    if prodiction_pre_mean(2)<-pi/2
        prodiction_pre_mean(2)=-pi-prodiction_pre_mean(2);
    end
end

viewpoint=Pretreatment(data_all,time);
viewpoint_now=viewpoint(:,:,user);
error=[prodiction_pre_mean(1)*ones([length(viewpoint_pre),1]),prodiction_pre_mean(2)*ones([length(viewpoint_pre),1])]-viewpoint_now;
for i=1:length(error)
    if error(i,1)>pi
        error(i,1)=error(i,1)-2*pi;
    elseif error(i,1)<-pi
        error(i,1)=error(i,1)+2*pi;
    end
end
sigmaxx=sum(error.^2)/length(error);
sigma11=sigmaxx(1);
errorsigma = [errorsigma,sqrt(sigma11)];
sigma22=sigmaxx(2);
sigma12=(error(:,1).')*error(:,2)/length(error);

sigma=[sigma11,sigma12;sigma12,sigma22];

prodiction_now=zeros(size(viewpoint_now));
i=(1:length(viewpoint_now)).';
px=polyfit(i,viewpoint_now(:,1),1);
py=polyfit(i,viewpoint_now(:,2),1);
for i=1:length(viewpoint)
    prodiction_now(i,1)=px(1)*(interval*length(viewpoint_now)+i)+px(2);
    prodiction_now(i,2)=py(1)*(interval*length(viewpoint_now)+i)+py(2);
end
prodiction_now_mean=mean(prodiction_now);
while(prodiction_now_mean(1)>2*pi)
    prodiction_now_mean(1)=prodiction_now_mean(1)-2*pi;
end
while(prodiction_now_mean(1)<0)
    prodiction_now_mean(1)=prodiction_now_mean(1)+2*pi;
end
while(prodiction_now_mean(2)>pi/2||prodiction_now_mean(2)<-pi/2)
    if prodiction_now_mean(2)>pi/2
        prodiction_now_mean(2)=pi-prodiction_now_mean(2);
    end
    if prodiction_now_mean(2)<-pi/2
        prodiction_now_mean(2)=-pi-prodiction_now_mean(2);
    end
end
r=mvnrnd(prodiction_now_mean,sigma,10000);

for i=1:length(r)
    while(r(i,1)>2*pi)
        r(i,1)=r(i,1)-2*pi;
    end
    while(r(i,1)<0)
        r(i,1)=r(i,1)+2*pi;
    end
    while(r(i,2)>pi/2||r(i,2)<-pi/2)
        if r(i,2)>pi/2
            r(i,2)=pi-r(i,2);
        end
        if r(i,2)<-pi/2
            r(i,2)=-pi-r(i,2);
        end
    end
end
probability=probability_cross(r);
end

