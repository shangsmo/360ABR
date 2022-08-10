a=readdata('2','3');
interval=1;
user=48;
time=223;
bw=ones([1,time])*100;
timec=zeros([1,time]);
ct=timec;
tilenum=zeros([1,time]);
for i=1+interval:time-interval
    [~,probability]=probability_mix(a,user,i,interval);
    probability=fovtile(probability);
    rate=abr_GT(bw(i),probability);
    for x=0:11
        for y=0:5
            if rate(y+1,x+1)>1
                [t,c]=download(rate(y+1,x+1),i,[x,y]);
                timec(i)=timec(i)+t;
                ct(i)=ct(i)+c;
                tilenum(i)=tilenum(i)+1;
            end
        end
    end
    bw(i+1)=th(i+1);
end