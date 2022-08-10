function [bitrate] = abr_RL(bw,weigth,agent,env,simOptions)
global World;
[m,n] = size(weigth);
p = zeros([m*n,2]);
for i = 1:m
    for j = 1:n
        p(j+(i-1)*n,1)=weigth(i,j);
        p(j+(i-1)*n,2) = j+(i-1)*n;
    end
end
p = sortrows(p,1,'descend');
createworld(bw,p);
experience = sim(env,agent,simOptions);
experience.Action.actions.TimeInfo.StartDate = '10/27/2005';
len = length(getabstime(experience.Action.actions));
tmp = getdatasamples(experience.Action.actions,[1:len]);
res = p;
for i = 1:m*n
    if i<=len
        res(i,1) = tmp(1,1,i);
    else
        res(i,1) = 0;
    end
end
res = sortrows(res,2);

bitrate = zeros(size(weigth));
for i = 1:m
    for j = 1:n
        bitrate(i,j)=res(j+(i-1)*n,1);
    end
end
end

