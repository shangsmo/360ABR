function createworld(bw,p)
global World N_tiles bitrate init;
World.probility = zeros([N_tiles,1]);
World.bitrate = bitrate;
World.th = bw;
id = unidrnd(N_tiles,1,40);
for i=1:25
    World.probility(id(i)) = World.probility(id(i)) + rand(1);
end
sums = sum(World.probility);
for i=1:N_tiles
    World.probility(i) = World.probility(i)/sums;
end

World.probility = p(:,1);
if init
    World.pre_quality = 0;
    init = false;
end
end

