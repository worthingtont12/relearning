function [statesFromEpisodes, actionsFromEpisodes, rewardsFromEpisodes] = ...
        getEpisodes_randomWalk19(stateSpace, policy, num_episodes )
% This function generates episodes for the 19-states random walk example in
% Sutton&Barto (Example 7.1). State 0 is the left terminal state and state
% 20 is the right terminal state. The reward is -1 from state 1 to state 0,
% and its 1 from state 19 to state 20.
% For simplicty, actionsFromEpisodes is not stored. Also note that
% policy is not used in the gerating process. (We keep 
% this parameter here to make it compatible with other functions, e.g.,
% TD0, MCeveryVisit ...)


% initialization
statesFromEpisodes = cell(num_episodes,1);
actionsFromEpisodes = cell(num_episodes,1);
rewardsFromEpisodes = cell(num_episodes,1);

for i = 1:num_episodes
    states = zeros(1000,1); % assume no episode lasts longer than 10000 walks
    states(1) = 10; %start at the center state
    rewards = zeros(1000,1);
    state = states(1); 
    len_episode = 1;
    while ~ismember(state,[0 20])
        if binornd(1,0.5)<1 % take action left
            if state == 1
                next_state = 0;
                reward = -1;
            else
                next_state = state - 1;
                reward = 0;
            end
        else % take action right
            if state == 19
                next_state = 20;
                reward = 1;
            else
                next_state = state + 1;
                reward = 0;
            end
        end
        state = next_state;
        len_episode = len_episode + 1;
        states(len_episode) = state;
        rewards(len_episode - 1) = reward;
    end
    statesFromEpisodes{i} = states(1:len_episode);
    rewardsFromEpisodes{i} = rewards(1:len_episode - 1);
end 
end