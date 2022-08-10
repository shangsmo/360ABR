function [t,c]=download(quality,chunk,tile)
%DOWNLOAD 此处显示有关此函数的摘要
%   此处显示详细说明
path='./xxx/';
server='http://10.112.254.249/';
video='2-4-FemaleBasketball';
quality=[num2str(quality),'k/'];
chunk=num2str(chunk);
filepath=[path,chunk];
mkdir(filepath); %创建文件夹pottmp
tile=['(',num2str(tile(1)),',',num2str(tile(2)),')'];
fullURL=[server,video,'/',quality,video,tile,chunk,'.mp4'];
filename=[filepath,'/',video,tile,chunk,'.mp4']; %保存的文件名
tic;

[f,status]=urlwrite(fullURL,filename);%下载命令
if status==1
    t=toc;
    lst=dir(filename);
    xi=lst.bytes;
    c=xi/1024/1024*8;
    disp([video,tile,chunk,'下载成功','文件大小为',num2str(xi/1024/1024),'MB',' 花费',num2str(t),'s,','吞吐量为',num2str(xi/t/1024*8),'kbps']);
else
    disp([video,tile,chunk,'下载失败']);
end
end

