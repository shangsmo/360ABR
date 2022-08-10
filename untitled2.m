fullURL = 'http://10.112.254.249/1.html';
filename='./xxx/1.mp4';
urlwrite(fullURL,filename);
tic;

[f,status]=urlwrite(fullURL,filename);%下载命令
if status==1
    t=toc;
    lst=dir(filename);
    xi=lst.bytes;
    disp([filename,'下载成功,文件大小为',num2str(xi/1024/1024),'MB,花费',num2str(t),'s,,吞吐量为',num2str(xi/t/1024*8),'kbps']);
else
    disp([filename,'下载失败']);
end