function [NextObs,Reward,IsDone,LoggedSignals] = myStepFunction(Action,LoggedSignals)
% Custom step function to construct environment for the function
% name case.
%
% This function applies the given action to the environment and evaluates
% the system dynamics for one simulation step.

% Define the environment constants.
global bitrate World;

% Check if the given action is valid.
if ~ismember(Action,bitrate)
    error('Action must be in Action Set.');
end

% Unpack the state vector from the logged signals.
State = LoggedSignals.State;
bandwidth = State{1};
nextTileSize = State{2};
preTileQ = State{3};
preTileP = State{4};
tmp = State{5};
chunkSize = State{6};
lastsegQ = State{7};
step = State{8};


% Perform Euler integration.

preTileQ(step) = bit2Q(Action);

preTileP = World.probility;
nextTileP = 0;
if step < 72
    nextTileP = World.probility(step+1);
end
chunkSize = chunkSize + Action;
step = step + 1;
LoggedSignals.State = [{bandwidth},{nextTileSize},{preTileQ},{preTileP},{nextTileP},{chunkSize},{lastsegQ},{step}];
% Transform state to observation.
NextObs = LoggedSignals.State;

% Check terminal condition.
step = NextObs{end};

IsDone = (step > 72)||preTileP(step-1)<=0.1/15;%||chunkSize>=bandwidth;

% Get reward.
    
if IsDone
    Reward = sum(preTileP.*(preTileQ-0.3*abs(preTileQ-lastsegQ))) - 15*max([chunkSize/bandwidth-1,0]);
    World.pre_quality = preTileP'*preTileQ;
else
    Reward = 0;
end

end