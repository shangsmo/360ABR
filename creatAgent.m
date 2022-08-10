
global N_tiles N_bitrate bitrate init World;

BandwidthPath = [
    imageInputLayer([1 1 1],'Normalization','none','Name','BandWidth')
    fullyConnectedLayer(128,'Name','BandwidthFC')
    leakyReluLayer('Name','BandwidthRelu')
    layerNormalizationLayer('Name','bin1')
    ];

SelectableBitratePath = [
    imageInputLayer([N_bitrate 1 1],'Normalization','none','Name','SelectableBitrate')
    fullyConnectedLayer(128,'Name','SelectableBitrateCNN')
    leakyReluLayer('Name','SelectableBitrateRelu')
    layerNormalizationLayer('Name','bin2')
    ];

PreTileQualityPath = [
    imageInputLayer([N_tiles 1 1],'Normalization','none','Name','PreTileQuality')
    fullyConnectedLayer(128,'Name','PreTileQualityCNN')
    leakyReluLayer('Name','PreTileQualityRelu')
    layerNormalizationLayer('Name','bin3')
    ];

PreTileProbabilityPath = [
    imageInputLayer([N_tiles 1 1],'Normalization','none','Name','PreTileProbability')
    fullyConnectedLayer(128,'Name','PreTileProbabilityCNN')
    leakyReluLayer('Name','PreTileProbabilityRelu')
    layerNormalizationLayer('Name','bin4')
    ];

NextTileProbabilityPath = [
    imageInputLayer([1 1 1],'Normalization','none','Name','NextTileProbability')
    fullyConnectedLayer(128,'Name','NextTileProbabilityFC')
    leakyReluLayer('Name','NextTileProbabilityRelu')
    layerNormalizationLayer('Name','bin5')
    ];

PreTileSizePath = [
    imageInputLayer([1 1 1],'Normalization','none','Name','PreTileSize')
    fullyConnectedLayer(128,'Name','PreTileSizeFC')
    leakyReluLayer('Name','PreTileSizeRelu')
    layerNormalizationLayer('Name','bin6')
    ];

LastSegQuailtyPath = [
    imageInputLayer([1 1 1],'Normalization','none','Name','LastSegQuailty')
    fullyConnectedLayer(128,'Name','LastSegQuailtyFC')
    leakyReluLayer('Name','LastSegQuailtyRelu')
    layerNormalizationLayer('Name','bin7')
    ];

StepPath = [
    imageInputLayer([1 1 1],'Normalization','none','Name','Step')
    fullyConnectedLayer(128,'Name','StepFC')
    leakyReluLayer('Name','StepRelu')
    layerNormalizationLayer('Name','bin8')
    ];

CommonPath = [
    concatenationLayer(3,8,'Name','merge')
    fullyConnectedLayer(1024,'Name','Foward1')
    leakyReluLayer
    fullyConnectedLayer(256,'Name','Foward2')
    leakyReluLayer
    layerNormalizationLayer('Name','norm')
    fullyConnectedLayer(N_bitrate,'Name','output')
    ];

criticNetwork = layerGraph(BandwidthPath);

criticNetwork = addLayers(criticNetwork, SelectableBitratePath);

criticNetwork = addLayers(criticNetwork, PreTileQualityPath);

criticNetwork = addLayers(criticNetwork, PreTileProbabilityPath); 

criticNetwork = addLayers(criticNetwork, NextTileProbabilityPath); 

criticNetwork = addLayers(criticNetwork, PreTileSizePath); 

criticNetwork = addLayers(criticNetwork, LastSegQuailtyPath); 

criticNetwork = addLayers(criticNetwork, StepPath);

criticNetwork = addLayers(criticNetwork, CommonPath); 

criticNetwork = connectLayers(criticNetwork,'bin1','merge/in1');
criticNetwork = connectLayers(criticNetwork,'bin2','merge/in2');
criticNetwork = connectLayers(criticNetwork,'bin3','merge/in3');
criticNetwork = connectLayers(criticNetwork,'bin4','merge/in4');
criticNetwork = connectLayers(criticNetwork,'bin5','merge/in5');
criticNetwork = connectLayers(criticNetwork,'bin6','merge/in6');
criticNetwork = connectLayers(criticNetwork,'bin7','merge/in7');
criticNetwork = connectLayers(criticNetwork,'bin8','merge/in8');

figure

plot(criticNetwork)

%%
criticOpts = rlOptimizerOptions('LearnRate',0.001,'GradientThreshold',1);

obsInfo = getObservationInfo(env);

actInfo = getActionInfo(env);

critic = rlVectorQValueFunction(criticNetwork,obsInfo,actInfo,ObservationInputNames=[{'BandWidth'},{'SelectableBitrate'},{'PreTileQuality'},{'PreTileProbability'},{'NextTileProbability'},{'PreTileSize'},{'LastSegQuailty'},{'Step'}]);
%critic = rlQValueRepresentation(criticNetwork,obsInfo,actInfo,'Observation',[{'BandWidth'},{'SelectableBitrate'}],'Action',{'Action'},criticOpts);

agentOpts = rlDQNAgentOptions(...
    'UseDoubleDQN',true, ...  
    'TargetUpdateMethod',"periodic", ...
    'TargetUpdateFrequency',4, ...   
    'ExperienceBufferLength',1000000, ...
    'DiscountFactor',1, ...
    'CriticOptimizerOptions',criticOpts, ...
    'MiniBatchSize',256);

agent = rlDQNAgent(critic,agentOpts);

