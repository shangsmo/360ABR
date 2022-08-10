a=readdata('2','0');
interval=4;
user=48;
time=270;
bw=100;
q_mix=zeros([1,time]);
q_lr=zeros([1,time]);
q_kal=zeros([1,time]);
q_cross=zeros([1,time]);

for i=1+interval:time-interval
    [p]=weight_mix(a,user,i,interval); 
    for j=1:length(p)
        q_mix(i)=q_mix(i)+xlogxbw(p(:,:,j),bw);
    end
end
blank_mix=isnan(q_mix);

for i=1:time-interval
    [p]=weight_lr(a,user,i,interval); 
    for j=1:length(p)
        q_lr(i)=q_lr(i)+xlogxbw(p(:,:,j),bw);
    end
end
blank_lr=isnan(q_lr);

for i=1+interval:time-interval
    [p]=weight_kal(a,user,i,interval);
    for j=1:length(p)
        q_kal(i)=q_kal(i)++xlogxbw(p(:,:,j),bw);
    end
end
blank_kal=isnan(q_kal);

for t=1:time
    [p]=weight_cross(a,t);

    for j=1:length(p)
        q_cross(t)=q_cross(t)++xlogxbw(p(:,:,j),bw);
    end
end
blank_cross=isnan(q_cross);

figure;
boxplot([q_lr',q_kal',q_cross',q_mix'],'Notch','off','Labels',{'lr','kal','cross','mix'},'symbol','r')
title('quality')