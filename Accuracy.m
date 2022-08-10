global errorsigma;
errorsigma = []
a=readdata('2','8');
interval=1;
time=300;
w=zeros([1,time]);
a_mix=ones([1,time]);
a_lr=ones([1,time]);
a_kal=ones([1,time]);
a_cross=ones([1,time]);
user=46;
%for i=1:(time-interval)*10/10
 %   [w(i),a_mix(i),~]=accuracy_mix(a,user,i/10*10,interval);
%end

for i=1:(time-interval)*10/10
    [a_lr(i),~]=accuracy_lr(a,user,i/10*10,interval);
end

for i=1:(time-interval)*10/10
    [a_kal(i),p]=accuracy_kal(a,user,i/10*10,interval);
end

for i=1:time*10/10
    [a_cross(i),~]=accuracy_cross(a,i/10*10);
end