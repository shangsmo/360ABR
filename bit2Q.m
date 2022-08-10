function [Q] = bit2Q(bit)
%BIT2Q 此处显示有关此函数的摘要
%   此处显示详细说明
global bitrate;
Q_list = [0,20,30,35,39,41,45];
id = find(bitrate==bit);
Q=Q_list(id);
end

