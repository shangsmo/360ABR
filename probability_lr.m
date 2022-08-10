function [probability] = probability_lr(viewpoint,interval)
%PROBABILITY_LR 此处显示有关此函数的摘要
%   此处显示详细说明
prodiction=zeros(size(viewpoint));
i=(1:length(viewpoint)).';
px=polyfit(i,viewpoint(:,1),1);
py=polyfit(i,viewpoint(:,2),1);
for i=1:length(viewpoint)
    prodiction(i,1)=px(1)*(interval*length(viewpoint)+i)+px(2);
    prodiction(i,2)=py(1)*(interval*length(viewpoint)+i)+py(2);
end

for i=1:length(viewpoint)
    while(prodiction(i,1)>2*pi)
        prodiction(i,1)=prodiction(i,1)-2*pi;
    end
    while(prodiction(i,1)<0)
        prodiction(i,1)=prodiction(i,1)+2*pi;
    end
    while(prodiction(i,2)>pi/2||prodiction(i,2)<-pi/2)
        if prodiction(i,2)>pi/2
            prodiction(i,2)=pi-prodiction(i,2);
        end
        if prodiction(i,2)<-pi/2
            prodiction(i,2)=-pi-prodiction(i,2);
        end
    end
end

probability=probability_cross(prodiction);
end

