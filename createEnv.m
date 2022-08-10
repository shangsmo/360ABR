global N_tiles N_bitrate bitrate;
bitrate = [0 10 20 50 100 150,250];
N_bitrate = length(bitrate);
N_tiles = 72;

bandwidthInfo = rlNumericSpec([1 1]);
bitrateInfo = rlNumericSpec([N_bitrate 1]);
preTileQInfo = rlNumericSpec([N_tiles 1]);
preTilePInfo = rlNumericSpec([N_tiles 1]);
nextTilePInfo = rlNumericSpec([1 1]);
chunkSizeInfo = rlNumericSpec([1 1]);
lastSegQInfo = rlNumericSpec([1 1]);
stepInfo = rlNumericSpec([1 1]);


bandwidthInfo.Name = 'bandwidth';
bitrateInfo.Name = 'bitrate';
preTileQInfo.Name = 'preTileQ';
preTilePInfo.Name = 'preTileP';
nextTilePInfo.Name = 'nextTileP';
chunkSizeInfo.Name = 'chunkSize';
lastSegQInfo.Name = 'lastSegQ';
stepInfo.Name = 'step';

obsInfo = [bandwidthInfo,bitrateInfo,preTileQInfo,preTilePInfo,nextTilePInfo,chunkSizeInfo,lastSegQInfo,stepInfo];

actInfo = rlFiniteSetSpec(bitrate);
actInfo.Name = 'actions';

env = rlFunctionEnv(obsInfo,actInfo,'myStepFunction','myResetFunction');