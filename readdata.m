function [data] = readdata(experiment,video)
%READDATA �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
data = struct;
for user=1:48
    Path=['..\vr-dataset\Formated_Data\Experiment_',num2str(experiment),'\',num2str(user),'\','video_',num2str(video),'.csv'];
    %data.=csvread(Path,1,1);
    field=['user',num2str(user)];
    data=setfield(data,field,csvread(Path,1,1));
end
end

