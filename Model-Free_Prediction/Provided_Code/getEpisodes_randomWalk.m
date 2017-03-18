function [statesFromEpisodes, actionsFromEpisodes, rewardsFromEpisodes] = ...
        getEpisodes_randomWalk(stateSpace, policy, num_episodes )
% This function generates episodes for the random walk example in
% Sutton&Barto (Example 6.2)
% For simplicty, actionsFromEpisodes is not stored. Also note that
% the policy parameter is not used in the gerating process. (We keep 
% this here to make it compatible with other functions, e.g.,
% TD0, MCeveryVisit ...)

% state 1 - A, state 2 - B, state 3 - C (initial state), state 4 - D,
% state 5 - E, state 0 - left terminal, state 6 - right terminal


% initialization
statesFromEpisodes = cell(num_episodes,1);
actionsFromEpisodes = cell(num_episodes,1);
rewardsFromEpisodes = cell(num_episodes,1);

for i = 1:num_episodes
    states = zeros(200,1); % assume no episode lasts longer than 200 walks
    states(1) = 3;
    rewards = zeros(200,1);
    state = 3;
    len_episode = 1;
    while ~ismember(state,[0 6])
        if binornd(1,0.5)<1 % take action left
            if state == 1
                next_state = 0;
                reward = 0;
            else
                next_state = state - 1;
                reward = 0;
            end
        else % take action right
            if state == 5
                next_state = 6;
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