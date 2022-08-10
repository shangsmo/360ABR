a=readdata('2','1');
interval=1;
user=46;
po=0;
for i=1:340-interval
    [p]=weight_lr(a,user,i,interval);

    m=mean(p(2,3,:));
    po=[po,m];
end