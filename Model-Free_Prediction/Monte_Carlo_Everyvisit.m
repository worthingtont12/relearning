function [v_pi, all_v_pi] = MCeveryVisit(stateSpace,getEpisodes,policy, alpha, gamma, initial_v_pi, num_episodes)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function implements the Monte Carlo every visit algorithm. It
% estimates the state value function v(s) under a given policy.
% Inputs: stateSpace: matrix - 1st dimension is # of states, 2nd is # of
%           atributes for a given state. For example, every state in the
%           black jack example is a row vector with three elements.
%         getEpisodes: user-defined function that generates episodes
%           under the given policy
%         policy: matrix - 1st dimension is # of states, 2nd is # of
%           actions. policy(s,a) is pi(a-th action | s-th state)
%         alpha: learning rate. If alpha = 0, update v using v(s) = v(s) +
%           1/N(s)*(G - v(s)), otherwise use v(s) = v(s) + alpha*(G - v(s))
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


%increment counter
    %N(s) <- N(s) +1
    % visit state
    %increment total return
        %S(s) <- S(s) + Gt
    % Determine value function for state
        %v(s) = v(s) + 1/N(s)*(G - v(s))
% terminating condition of game
%stop when N(s) = num_episodes

v_pi = initial_v_pi;
all_v_pi = zeros(length(stateSpace), num_episodes);
Ns = zeros(length(stateSpace), 1);

[statesFromEpisodes,actionsFromEpisodes,rewardsFromEpisodes] = getEpisodes(stateSpace, policy, num_episodes);
statesFromEpisodes = transpose(statesFromEpisodes);
actionsFromEpisodes = transpose(actionsFromEpisodes);
rewardsFromEpisodes = transpose(rewardsFromEpisodes);

for i = 1:num_episodes
    for j = 1:(length(statesFromEpisodes{i}) - 1)
        state = [statesFromEpisodes{i}(j,:)];
        state_index = find(all(repmat(state,length(stateSpace),1) == stateSpace, 2));
        Ns(state_index) = Ns(state_index) + 1;
        %visit state and collect rewards
        reward = rewardsFromEpisodes{i}(j:length(rewardsFromEpisodes{i}));
        Gt = dot(reward, (gamma.^-(0:(length(reward)-1))));
        % Determine value function for state
            %v(s) = v(s) + 1/N(s)*(G - v(s))
        if alpha == 0
            v = v_pi(state_index) + (1/Ns(state_index))*((Gt) - v_pi(state_index));
        else %v(s) = v(s) + alpha*(G - v(s))
            v = v_pi(state_index) + (alpha)*((Gt) - v_pi(state_index));
        end
            %save v_pi for s
        v_pi(state_index) = v;
    end
    all_v_pi(:,i) = (v_pi);
end
end
