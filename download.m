function [t,c]=download(quality,chunk,tile)
%DOWNLOAD �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
path='./xxx/';
server='http://10.112.254.249/';
video='2-4-FemaleBasketball';
quality=[num2str(quality),'k/'];
chunk=num2str(chunk);
filepath=[path,chunk];
mkdir(filepath); %�����ļ���pottmp
tile=['(',num2str(tile(1)),',',num2str(tile(2)),')'];
fullURL=[server,video,'/',quality,video,tile,chunk,'.mp4'];
filename=[filepath,'/',video,tile,chunk,'.mp4']; %������ļ���
tic;

[f,status]=urlwrite(fullURL,filename);%��������
if status==1
    t=toc;
    lst=dir(filename);
    xi=lst.bytes;
    c=xi/1024/1024*8;
    disp([video,tile,chunk,'���سɹ�','�ļ���СΪ',num2str(xi/1024/1024),'MB',' ����',num2str(t),'s,','������Ϊ',num2str(xi/t/1024*8),'kbps']);
else
    disp([video,tile,chunk,'����ʧ��']);
end
end

