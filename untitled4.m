fpsnr=zeros([6,12]);
fbitrate_rl=zeros([6,12]);
qoe_rl=zeros([1,time]);
fovbit_rl=zeros([1,time]);
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