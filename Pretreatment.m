function [data_pt] = Pretreatment(data_all,time)
%PRETREATMENT 数据集预处理
%   此处显示详细说明
%   批量读取某视频的视点轨迹后坐标转化
d=90;
for user=1:48
    data=getfield(data_all,['user',num2str(user)]);
    t=1;
    while(data(t,1)<time)
        t=t+1;
    end
    data_q=data(t:t+d-1,1:5);
    data_xyz=zeros([length(data_q),4]);
    for l=1:d
        data_xyz(l,1)=2*(data_q(l,2)*data_q(l,4)+data_q(l,3)*data_q(l,5));
        data_xyz(l,2)=2*(data_q(l,3)*data_q(l,4)-data_q(l,2)*data_q(l,5));
        data_xyz(l,3)=1-2*(data_q(l,2)^2+2*data_q(l,3)^2);
        data_xyz(l,4)=data_q(l,1);
    end
    
    for l=1:d
        if data_xyz(l,3)>0
            data_pt(l,1,user)=2*pi-acos(data_xyz(l,1)/sqrt(data_xyz(l,1)^2+data_xyz(l,3)^2))+pi/4;
        else
            data_pt(l,1,user)=acos(data_xyz(l,1)/sqrt(data_xyz(l,1)^2+data_xyz(l,3)^2))+pi/4;
        end
        data_pt(l,2,user)=atan(data_xyz(l,2)/sqrt(data_xyz(l,1)^2+data_xyz(l,3)^2));
    end
end
end

