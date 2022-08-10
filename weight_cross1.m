accuracy=zeros([1,340]);
a=readdata('2','1');
po=0;
for t=1:340
    [p]=weight_cross(a,t);

    m=mean(p(2,3,:));
    po=[po,m];
end