filepath='./xx/';
server='http://localhost/';
video='FemaleBasketball';
mkdir(filepath); %�����ļ���pottmp


quality='quality_100/';
chunk='1';
tile='(0,0)';
fullURL=[server,quality,video,tile,chunk,'.mp4'];
filename=[filepath,video,tile,chunk,'.mp4']; %������ļ���
tic;
[f,status]=urlwrite(fullURL,filename);%��������
if status==1
    t=toc;
   lst=dir(filename);
   xi=lst.bytes;
   disp([video,tile,chunk,'���سɹ�','�ļ���СΪ',num2str(xi/1024/1024),'MB',' ����',num2str(t),'s,','������Ϊ',num2str(xi/t/1024*8),'kbps']);
else
   disp([video,tile,chunk,'����ʧ��']);
end
