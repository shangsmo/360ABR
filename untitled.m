filepath='./xx/';
server='http://localhost/';
video='FemaleBasketball';
mkdir(filepath); %创建文件夹pottmp


quality='quality_100/';
chunk='1';
tile='(0,0)';
fullURL=[server,quality,video,tile,chunk,'.mp4'];
filename=[filepath,video,tile,chunk,'.mp4']; %保存的文件名
tic;
[f,status]=urlwrite(fullURL,filename);%下载命令
if status==1
    t=toc;
   lst=dir(filename);
   xi=lst.bytes;
   disp([video,tile,chunk,'下载成功','文件大小为',num2str(xi/1024/1024),'MB',' 花费',num2str(t),'s,','吞吐量为',num2str(xi/t/1024*8),'kbps']);
else
   disp([video,tile,chunk,'下载失败']);
end
