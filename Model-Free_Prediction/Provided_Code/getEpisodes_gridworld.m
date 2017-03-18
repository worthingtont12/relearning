function [ statesFromEpisodes, actionsFromEpisodes, rewardsFromEpisodes ]...
        = getEpisodes_gridworld(stateSpace, policy, num_episodes )
% This function generates episodes for the gridworld example under a given
% policy
statesFromEpisodes = cell(num_episodes,1);
actionsFromEpisodes = cell(num_episodes,1);
rewardsFromEpisodes = cell(num_episodes,1);
num_states = size(stateSpace,1);
num_actions = size(policy,2);

% grid world setup
% immediate reward
r = -ones(15,15,4);
r(15,:,:)=0;
% transition Probabilities P_ss'^a
P = zeros(15,15,4); 
P(15,15,:)=1;
    % for action = 1 (left)
    P(1,15,1)=1; P(2,1,1)=1; P(3,2,1)=1; P(4,4,1)=1; P(5,4,1)=1;
    P(6,5,1)=1; P(7,6,1)=1; P(8,8,1)=1; P(9,8,1)=1; P(10,9,1)=1;
    P(11,10,1)=1; P(12,12,1)=1; P(13,12,1)=1; P(14,13,1)=1;
    % for action = 2 (up)
    P(1,1,2)=1; P(2,2,2)=1; P(3,3,2)=1; P(4,15,2)=1;
    for i=5:14
        P(i,i-4,2)=1;
    end
    % for action = 3 (right)
    P(1,2,3)=1; P(2,3,3)=1; P(3,3,3)=1; P(4,5,3)=1; P(5,6,3)=1;
    P(6,7,3)=1; P(7,7,3)=1; P(8,9,3)=1; P(9,10,3)=1; P(10,11,3)=1;
    P(11,11,3)=1; P(12,13,3)=1; P(13,14,3)=1; P(14,15,3)=1;
    % for action = 4 (down)
    for i=1:10
        P(i,i+4,4)=1;
    end
    P(11,15,4)=1; P(12,12,4)=1; P(13,13,4)=1; P(14,14,4)=1;

initialStates = 1:14;  
terminalStates = 15; 

% generate epsidoes
for i = 1:num_episodes
    % preallocation , assume no episode lasts longer than 500 transitions
    states = zeros(500,1);
    actions = zeros(500,1);
    rewards = zeros(500,1);
    
    %generate initial state randomly from all possible initial states
    
    current_state = randsample(initialStates,1,true);
    states(1) = current_state;
    len_episodes = 1; 
 
    while ~ismember(current_state,terminalStates)
        len_episodes = len_episodes + 1;
        action = randsample(num_actions,1,'true',policy(current_state,:));
        actions(len_episodes - 1) = action;
        next_state = randsample(num_states,1,'true', ...
                                P(current_state,:,action));
        states(len_episodes) = next_state;
        reward = r(current_state,next_state, action);
        rewards(len_episodes - 1) = reward;
        current_state = next_state;
    end
    
    statesFromEpisodes{i} = states(1:len_episodes);
    actionsFromEpisodes{i} = actions(1:len_episodes-1);
    rewardsFromEpisodes{i} = rewards(1:len_episodes-1);
end
    
end

