function [InitialObservation, LoggedSignal] = myResetFunction()
% Reset function to place custom cart-pole environment into a random
% initial state.
global World N_tiles bitrate;

preTileQ = zeros([N_tiles,1]);
preTileP = World.probility;


% Return initial environment state variables as logged signals.
LoggedSignal.State = [{World.th};{bitrate'};{preTileQ};{preTileP};{World.probility(1)};{0};{World.pre_quality};{1}];
InitialObservation = LoggedSignal.State;

end