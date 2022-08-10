
% 准备一张自己的背景图片
img = imread('20201221-174628.PNG');
% 设置图片在绘制时的尺寸
min_x = 0;
max_x = 2*pi;
min_y = -pi/2;
max_y = pi/2;
 
%插入背景图?
 
imagesc([min_x max_x], [min_y max_y], flipdim(img,1));

hold on;
 
%绘制自己的图形
scatter(data_pt_1s(:,1),data_pt_1s(:,2),20,c,'filled');
%plot(data_pt_1s(:,1),data_pt_1s(:,2),'.')
xticks([0 pi/4 1/2*pi 3/4*pi pi 5/4*pi 6/4*pi 7/4*pi 2*pi])
xticklabels({'0','1/4\pi','1/2\pi','3/4\pi','\pi','5/4\pi','3/2\pi','7/4\pi','2\pi'})
yticks([-pi/2 -pi/4 0 pi/4 pi/2])
yticklabels({'-1/2\pi','-1/4\pi','0','1/4\pi','1/2\pi'})
xlim([0,2*pi])
ylim([-pi/2,pi/2])
set(gca,'ydir','normal');
set(gca,'FontSize',16);
