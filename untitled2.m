fullURL = 'http://10.112.254.249/1.html';
filename='./xxx/1.mp4';
urlwrite(fullURL,filename);
tic;

[f,status]=urlwrite(fullURL,filename);%��������
if status==1
    t=toc;
    lst=dir(filename);
    xi=lst.bytes;
    disp([filename,'���سɹ�,�ļ���СΪ',num2str(xi/1024/1024),'MB,����',num2str(t),'s,,������Ϊ',num2str(xi/t/1024*8),'kbps']);
else
    disp([filename,'����ʧ��']);
end