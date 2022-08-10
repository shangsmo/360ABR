a=readdata('2','3');
data_pt=Pretreatment(a,160);

c = linspace(1,48,48);
data_pt_1s=[data_pt(1,1,1),data_pt(1,2,1)];
for user=2:48
    data_pt_1s=[data_pt_1s;[data_pt(1,1,user),data_pt(1,2,user)]];
end
data_pt_1s=data_pt_1s(1:length(data_pt_1s),:);
z=probability_cross(data_pt_1s);
figure(1)
scatter(data_pt_1s(:,1),data_pt_1s(:,2),20,c,'filled');
%plot(data_pt_1s(:,1),data_pt_1s(:,2),'.')
xticks([0 pi/4 1/2*pi 3/4*pi pi 5/4*pi 6/4*pi 7/4*pi 2*pi])
xticklabels({'0','1/4\pi','1/2\pi','3/4\pi','\pi','5/4\pi','3/2\pi','7/4\pi','2\pi'})
yticks([-pi/2 -pi/4 0 pi/4 pi/2])
yticklabels({'-1/2\pi','-1/4\pi','0','1/4\pi','1/2\pi'})
xlim([0,2*pi])
ylim([-pi/2,pi/2])

figure(2)
width=1;
b=bar3(z,width);
for k = 1:length(b)
    zdata = get(b(k),'ZData');
    set(b(k),'CData',zdata);
    set(b(k),'FaceColor','interp');
end

%a=[data_pt(:,1,41),data_pt(:,2,41)];
figure(3)
plot(data_pt(:,1,41),data_pt(:,2,41));
%xlim([0,2*pi])
%ylim([-pi/2,pi/2])
