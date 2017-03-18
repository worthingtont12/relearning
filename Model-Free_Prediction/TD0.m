function [v_pi, all_v_pi] = TD0(stateSpace, getEpisodes,policy, alpha, ...
                            gamma, initial_v_pi, num_episodes)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function implements TD(0) algorithm. It estimates the state value
% function v(s) under a given policy.
% Inputs: stateSpace: matrix - 1st dimension is # of states, 2nd is # of
%           atributes for a given state. For example, every state in the
%           black jack example is a row vector with three elements.
%         getEpisodes: user-defined function that generates episodes
%           under the given policy
%         policy: matrix - 1st dimension is # of states, 2nd is # of
%           actions. policy(s,a) is pi(a-th action | s-th state)
%         alpha: learning rate
%         gamma: discount factor
%         initial_v_pi: vector - initial estimates for v_pi
%         num_episodes: number of episodes for the evaluation
% Outputs: v_pi: vector - final estimates for v_pi
%          all_v_pi: matrix of size #states x #episodes. It stores all
%                    estimates for v_pi after every episode
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Your code
%%%%%%%%%%%%%%%%%%%%%%%%%%%

v_pi = initial_v_pi;
all_v_pi = zeros(length(stateSpace), num_episodes);

[statesFromEpisodes,actionsFromEpisodes,rewardsFromEpisodes] = getEpisodes(stateSpace, policy, num_episodes);
statesFromEpisodes = transpose(statesFromEpisodes);
actionsFromEpisodes = transpose(actionsFromEpisodes);
rewardsFromEpisodes = transpose(rewardsFromEpisodes);

for i = 1:num_episodes
    for j = 1:(length(statesFromEpisodes{i})-1)
        state = [statesFromEpisodes{i}(j,:)];
        next_state = [statesFromEpisodes{i}((j+1),:)];
        state_index = find(all(repmat(state,length(stateSpace),1) == stateSpace, 2));
        next_state_index = find(all(repmat(next_state,length(stateSpace),1) == stateSpace, 2));
        % %visit state and collect rewards
        if j < (length(statesFromEpisodes{i})-1)
            next_reward = rewardsFromEpisodes{i}((j+1));
        else
            next_reward = 0;
        end
        % % Determine value function for state
        %v(st) = v(st) + alpha*(Rt+1 + (gamma)*(vst+1) - v(st))
        next_v = v_pi(next_state_index);
        v = v_pi(state_index) + (alpha)*(next_reward + (gamma)*(next_v) - v_pi(state_index));
            %save v_pi for s
        v_pi(state_index) = v;
    end
    all_v_pi(:,i) = v_pi;
end
end
%i'll always have one less reward then states
%so termintaing condition is zero
