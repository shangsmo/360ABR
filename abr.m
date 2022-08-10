a=readdata('2','3');
interval=1;
user=44;
time=6*60;
bw=normrnd(3000,200,1,time);
%bw = ones([1,360])*6000;
qoe_gt=zeros([1,time]);
qoe_mean=zeros([1,time]);
qoe_mutitire=zeros([1,time]);
qoe_vas=zeros([1,time]);
switch_gt=zeros([1,time]);
switch_mean=zeros([1,time]);
switch_mutitire=zeros([1,time]);
switch_vas=zeros([1,time]);
rebuffer_gt=zeros([1,time]);
rebuffer_mean=zeros([1,time]);
rebuffer_mutitire=zeros([1,time]);
rebuffer_vas=zeros([1,time]);
rebuffer_gp=zeros([1,time]);
rebuffer_rl = zeros([1,time]);
b_gt=zeros([1,time]);
b_mean=zeros([1,time]);
b_mutitire=zeros([1,time]);
b_vas=zeros([1,time]);
fbitrate_gt=zeros([6,12]);
fbitrate_mean=zeros([6,12]);
fbitrate_vas=zeros([6,12]);
fbitrate_mutitire=zeros([6,12]);
fovbit_gt=zeros([1,time]);
fovbit_mean=zeros([1,time]);
fovbit_mutitire=zeros([1,time]);
fovbit_vas=zeros([1,time]);
%qoe=zeros([1,time]);

pbw=bw;
for i = 4:length(bw)
    pbw(i) = (bw(i-3) + bw(i-2) + bw(i-1))/3 *0.9;
end


%GT
fovbit_gt(1) = 1;
for i=2+interval:time-interval
    [~,probability]=probability_mix(a,user,i,interval);
    probability=fovtile(probability);
    bitrate_gt=abr_GT(pbw(i),probability);
    weight=fovweight(a,user,i+interval);
    num=0;
    for x=1:6
        for y=1:12
            if bitrate_gt(x,y)>1
                l=find(bit==bitrate_gt(x,y));
                qoe_gt(i)= qoe_gt(i)+weight(x,y)*PSNR(x+(y-1)*6,l,i+interval);
                num=num+1;
            end
            if bitrate_gt(x,y)*fbitrate_gt(x,y)>1
                fl=find(bit==fbitrate_gt(x,y));
                switch_gt(i)=switch_gt(i)+weight(x,y)*abs(PSNR(x+(y-1)*6,l,i+interval)-PSNR(x+(y-1)*6,fl,i));
            end
            if weight(x,y)>=0.1/15
                fovbit_gt(i)=fovbit_gt(i)+bitrate_gt(x,y)/bw(i);
            end
        end
    end
    if num==0
        num=1;
    end
    b_gt(i)=sum(sum(bitrate_gt));
    rebuffer_gt(i)  = max([b_gt(i)/bw(i)-1,0]);
    fbitrate_gt=bitrate_gt;
    %qoe(i)=sum(sum(probability.*log10(gt_bitrate/0.0001)));
end

%mean
fovbit_mean(1) = 1;
for i=1+interval:time-interval
    data_now=Pretreatment(a,time);
    viewpoint_now=data_now(:,:,user);
    probability=ones([6,12]);
    bitrate_mean = abr_mean(pbw(i),probability);
    weight=fovweight(a,user,i+interval);
    num=0;
    for x=1:6
        for y=1:12
            if bitrate_mean(x,y)>1
                l=find(bit==bitrate_mean(x,y));
                qoe_mean(i)= qoe_mean(i)+weight(x,y)*PSNR(x+(y-1)*6,l,i+interval);
                num=num+1;
            end
            if bitrate_mean(x,y)*fbitrate_mean(x,y)>1
                fl=find(bit==fbitrate_mean(x,y));
                switch_mean(i)=switch_mean(i)+abs(weight(x,y)*(PSNR(x+(y-1)*6,l,i+interval)-PSNR(x+(y-1)*6,fl,i)));
            end
            if weight(x,y)>=0.1/15
                fovbit_mean(i)=fovbit_mean(i)+bitrate_mean(x,y)/bw(i);
            end
        end
    end
    if num==0
        num=1;
    end
    b_mean(i)=sum(sum(bitrate_mean));
    rebuffer_mean(i)  = max([b_mean(i)/bw(i)-1,0]);
    fbitrate_mean=bitrate_mean;
end

%mutitire
fovbit_mutitire(1)=1;
for i=1+interval:time-interval
    [a_lr,~]=accuracy_lr(a,user,i/10*10,interval);
    data_now=Pretreatment(a,time);
    viewpoint_now=data_now(:,:,user);
    probability=probability_lr(viewpoint_now,interval);
    probability=fovtile(probability);
    bitrate_mutitire=abr_mutitire(pbw(i),probability,a_lr);
    weight=fovweight(a,user,i+interval);
    num=0;
    for x=1:6
        for y=1:12
            if bitrate_mutitire(x,y)>0.01
                l=find(bit==bitrate_mutitire(x,y));
                qoe_mutitire(i)= qoe_mutitire(i)+weight(x,y)*PSNR(x+(y-1)*6,l,i+interval);
                num=num+1;
            end
            if bitrate_mutitire(x,y)*fbitrate_mutitire(x,y)>1
                fl=find(bit==fbitrate_mutitire(x,y));
                switch_mutitire(i)=switch_mutitire(i)+abs(weight(x,y)*(PSNR(x+(y-1)*6,l,i+interval)-PSNR(x+(y-1)*6,fl,i)));
            end
            if weight(x,y)>=0.1/15
                fovbit_mutitire(i)=fovbit_mutitire(i)+bitrate_mutitire(x,y)/bw(i);
            end
        end
    end
    if num==0
        num=1;
    end
    b_mutitire(i)=sum(sum(bitrate_mutitire));
    rebuffer_mutitire(i)  = max([b_mutitire(i)/bw(i)-1,0]);
    fbitrate_mutitire=bitrate_mutitire;
end

%vas
fovbit_vas(1) = 1;
for i=1+interval:time-interval
    [~,probability]=probability_mix(a,user,i,interval);
    probability=fovtile(probability);
    bitrate_vas=abr_mean(pbw(i),probability);
    weight=fovweight(a,user,i+interval);
    num=0;
    for x=1:6
        for y=1:12
            if bitrate_vas(x,y)>0.01
                l=find(bit==bitrate_vas(x,y));
                qoe_vas(i)= qoe_vas(i)+weight(x,y)*PSNR(x+(y-1)*6,l,i+interval);
                num=num+1;
            end
            if bitrate_vas(x,y)*fbitrate_vas(x,y)>1
                fl=find(bit==fbitrate_vas(x,y));
                switch_vas(i)=switch_vas(i)+abs(weight(x,y)*(PSNR(x+(y-1)*6,l,i+interval)-PSNR(x+(y-1)*6,fl,i)));
            end
            if weight(x,y)>=0.1/15
                fovbit_vas(i)=fovbit_vas(i)+bitrate_vas(x,y)/bw(i);
            end
        end
    end
    if num==0
        num=1;
    end
    b_vas(i)=sum(sum(bitrate_vas));
    rebuffer_vas(i)  = max([b_vas(i)/bw(i)-1,0]);
    fbitrate_vas=bitrate_vas;
end

%GP
fpsnr=zeros([6,12]);
fbitrate_gp=zeros([6,12]);
qoe_gp=zeros([1,time]);
fovbit_gp=zeros([1,time]);
fovbit_gp(1) = 1;
switch_gp=zeros([1,time]);
for i=1+interval:time-interval
    [~,probability]=probability_mix(a,user,i,interval);
    probability=fovtile(probability);
    [bitrate_gp,psnr]=abr_GP(floor(pbw(i)),probability,bit,PSNR(:,:,i+interval),fpsnr);
    weight=fovweight(a,user,i+interval);
    num=0;
    for x=1:6
        for y=1:12
            if bitrate_gp(x,y)>0.01
                l=find(bit==bitrate_gp(x,y));
                qoe_gp(i)= qoe_gp(i)+weight(x,y)*PSNR(x+(y-1)*6,l,i+interval);
                num=num+1;
            end
            if bitrate_gp(x,y)*fbitrate_gp(x,y)>1
                fl=find(bit==fbitrate_gp(x,y));
                switch_gp(i)=switch_gp(i)+abs(weight(x,y)*(PSNR(x+(y-1)*6,l,i+interval)-PSNR(x+(y-1)*6,fl,i)));
            end
            if weight(x,y)>=0.1/15
                fovbit_gp(i)=fovbit_gp(i)+bitrate_gp(x,y)/bw(i);
            end
        end
    end
    if num==0
        num=1;
    end
    b_gp(i)=sum(sum(bitrate_gp));
    rebuffer_gp(i)  = max([b_gp(i)/bw(i)-1,0]);
    fbitrate_gp=bitrate_gp;
    fpsnr=psnr;
end


%RL
fpsnr=zeros([6,12]);
fbitrate_rl=zeros([6,12]);
qoe_rl=zeros([1,time]);
fovbit_rl=zeros([1,time]);
fovbit_gp(1) = 1;
switch_rl=zeros([1,time]);
for i=1+interval:time-interval
    [~,probability]=probability_mix(a,user,i,interval);
    probability=fovtile(probability);
    bitrate_rl=abr_RL(pbw(i),probability,agent,env,simOptions);
    weight=fovweight(a,user,i+interval);
    num=0;
    for x=1:6
        for y=1:12
            if bitrate_rl(x,y)>0.01
                l=find(bit==bitrate_rl(x,y));
                qoe_rl(i)= qoe_rl(i)+weight(x,y)*PSNR(x+(y-1)*6,l,i+interval);
                num=num+1;
            end
            if bitrate_rl(x,y)*fbitrate_rl(x,y)>1
                fl=find(bit==fbitrate_rl(x,y));
                switch_rl(i)=switch_rl(i)+abs(weight(x,y)*(PSNR(x+(y-1)*6,l,i+interval)-PSNR(x+(y-1)*6,fl,i)));
            end
            if weight(x,y)>=0.1/15
                fovbit_rl(i)=fovbit_rl(i)+bitrate_rl(x,y)/bw(i);
            end
        end
    end
    if num==0
        num=1;
    end
    b_rl(i)=sum(sum(bitrate_rl));
    rebuffer_rl(i)  = max([b_rl(i)/bw(i)-1,0]);
    fbitrate_rl=bitrate_rl;
end
allqoe_vas = qoe_vas- 0.4 * switch_vas -10 * rebuffer_vas;
allqoe_mean = qoe_mean- 0.4 * switch_mean -10 * rebuffer_mean;
allqoe_gp = qoe_gp- 0.4 * switch_gp -10 * rebuffer_gp;
allqoe_gt = qoe_gt- 0.4 * switch_gt -10 * rebuffer_gt;
allqoe_rl = qoe_rl- 0.4 * switch_rl -10 * rebuffer_rl;
%figure;
%boxplot([qoe_gt',qoe_mean',qoe_mutitire',qoe_vas',qoe_gp'],'Notch','off','Labels',{'gt','mean','mutitire','vas','gp'},'symbol','r')
%title('quality')



figure;
[fgt,i]=ecdf(fovbit_gt);
I=plot(i,fgt','linewidth',2);
hold on
[fmean,k]=ecdf(fovbit_mean);
K=plot(k,fmean,'linewidth',2);
hold on
[fvas,l]=ecdf(fovbit_vas);
L=plot(l,fvas,'linewidth',2);
hold on
[fgp,m]=ecdf(fovbit_gp);
M=plot(m,fgp,'linewidth',2);
hold on
[frl,n]=ecdf(fovbit_rl);
N=plot(n,frl,'linewidth',2);
xlabel('Bandwidth Utilization Efficiency');
ylabel('CDF');
title('video-2')
legend([I K L N M],'Greedy','ERP','Tile','DDQN','DP','Location','Northwest');
legend boxoff;

figure;
i=ksdensity(fovbit_gt,'function','cdf');
I=plot(i,'linewidth',2);
hold on
%j=ksdensity(fovbit_mutitire,'function','cdf');
%J=plot(j,'linewidth',2);
%hold on
k=ksdensity(fovbit_mean,'function','cdf');
K=plot(k,'linewidth',2);
hold on
l=ksdensity(fovbit_vas,'function','cdf');
L=plot(l,'linewidth',2);
hold on
m=ksdensity(fovbit_gp,'function','cdf');
M=plot(m,'linewidth',2);
n=ksdensity(fovbit_rl,'function','cdf');
N=plot(n,'linewidth',2);
xlabel('Bandwidth Utilization (%)','fontsize',18);
ylabel('CDF','fontsize',18);
title('Hey VR Interview','fontsize',18)
set(gca,'FontSize',15);
legend([K L I N M],'ERP','Tile','Greedy','DDQN','DP','Location','Northwest');
legend boxoff;


figure;
I=plot(qoe_gt(134:153),'linewidth',2);
hold on
%j=ksdensity(fovbit_mutitire,'function','cdf');
%J=plot(j,'linewidth',2);
%hold on
K=plot(qoe_mean(134:153),'linewidth',2);
hold on
L=plot(qoe_vas(134:153),'linewidth',2);
hold on
M=plot(qoe_gp(134:153),'linewidth',2);
hold on
N=plot(qoe_rl(134:153),'linewidth',2);
xlabel('Index of Chunk','fontsize',18);
ylabel('PSNR','fontsize',18);
title('The Fight for Falluja','fontsize',18)
set(gca,'FontSize',15);
legend([K L I N M],'ERP','Tile','Greedy','DDQN','DP','Location','Northwest','NumColumns',5);
legend boxoff;
set(gcf,'unit','normalized','position',[0.2,0.2,0.4,0.32]);