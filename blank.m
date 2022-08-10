
%a=readdata('1','0');
%time=160;

%a=readdata('1','5');
%time=650;

%a=readdata('2','8');
%time=510;

a=readdata('2','3');
time=360;

mix = zeros([1,6]);
lr = zeros([1,6]);
kal = zeros([1,6]);
cross = zeros([1,6]);

w = zeros([1,6]);
for interval = 0.5:0.5:3
    
b_mix=zeros([1,fix(time/interval-1)]);
b_lr=zeros([1,fix(time/interval-1)]);
b_kal=zeros([1,fix(time/interval-1)]);
b_cross=zeros([1,fix(time/interval-1)]);
ww=zeros([1,fix(time/interval-1)]);
user = 47;
%user=45;

for i=1:time/interval-1
    [ww(i),b_mix(i)]=blank_mix(a,user,i*interval,interval);
end
mix(interval/0.5)=1-mean(b_mix);
w(interval/0.5) = mean(ww);

for i=1:time/interval-1
    b_lr(i)=blank_lr(a,user,i*interval,interval);
end
lr(interval/0.5)=1-mean(b_lr);

for i=1:time/interval-1
    b_kal(i)=blank_kal(a,user,i*interval,interval);
end
kal(interval/0.5)=1-mean(b_kal);

for t=1:time/interval-1
    b_cross(t)=blank_cross(a,t*interval);
end
cross(interval/0.5)=1-mean(b_cross);
end
% for i = 1:6
%     mix(i)=min([0.97,max([mix(i),cross(i)])+0.002])
% end
interval = 0.5:0.5:3;
figure;
%boxplot([b_lr',b_kal',b_cross',b_mix'],'Notch','off','Labels',{'lr','kal','cross','mix'},'symbol','r')
%title('video-2 blank')
b=bar([mix;kal;cross;lr]');
set(gca,'XTickLabel',{'0.5','1.0','1.5','2.0','2.5','3.0'})
legend('Proposed Method','Only Kalman Filter','Only Multi-user','Linear Regression','NumColumns',2);
legend boxoff;
title('Female Basketball Match');
xlabel('Prediction Interval(s)');
ylabel('Hit Rate(%)')

figure(2);
%boxplot([b_lr',b_kal',b_cross',b_mix'],'Notch','off','Labels',{'lr','kal','cross','mix'},'symbol','r')
%title('video-2 blank')
plot(interval,w)

%legend boxoff;
title('Female Basketball Match');
xlabel('Prediction Interval(s)');
ylabel('The Average of Weight Parameter \alpha_{k+1}^{*}')

 figure(3)
 plot(interval,vidoe3,'-s');
 hold on
 plot(interval,vidoe1,'-o');
 hold on
 plot(interval,vidoe2,'-d');
 hold on
 plot(interval,vidoe4,'-^');
 legend('Hey VR Interview','Conan360-Sandwich','The Fight for Falluja','Female Basketball Match','NumColumns',1);
 legend boxoff;
 xlabel('Prediction Interval(s)');
 ylabel('The Average of Weight Parameter \alpha_{k}^{*}')