function [v_pi, all_v_pi] = forwardtd_lamda(stateSpace, getEpisodes,policy, alpha, ...
                            gamma, initial_v_pi, num_episodes,lambda)
    v_pi = initial_v_pi;
    all_v_pi = zeros(length(stateSpace), num_episodes);
    Ns = zeros(length(stateSpace), 1);

    [statesFromEpisodes,actionsFromEpisodes,rewardsFromEpisodes] = getEpisodes(stateSpace, policy, num_episodes);
    statesFromEpisodes = transpose(statesFromEpisodes);
    actionsFromEpisodes = transpose(actionsFromEpisodes);
    rewardsFromEpisodes = transpose(rewardsFromEpisodes);
  
    for i = 1:num_episodes
        for j = 1:(length(statesFromEpisodes{i}) - 1)
            Gt_all = 0;
            state = [statesFromEpisodes{i}(j,:)];
            state_index = find(all(repmat(state,length(stateSpace),1) == stateSpace, 2));
            %visit state and collect rewards
                for J = 1:(length(statesFromEpisodes{i}) - 1)
                    reward = rewardsFromEpisodes{i}(J:length(rewardsFromEpisodes{i}));
                    Gt = dot(reward, (gamma.^-(0:(length(reward)-1))));
                    Gt_all = Gt_all + ((lambda^(J-1))*Gt);
                end
                Gtlambda = (1-lambda)*Gt_all;
            % Determine value function for state
            v = v_pi(state_index) + (alpha)*((Gtlambda) - v_pi(state_index));
                %save v_pi for s
            v_pi(state_index) = v;
        end
        all_v_pi(:,i) = (v_pi);
    end
end
%Results when tested on randomWalk19
% ------------------------------------
%  #episodes(walks) = 10; #runs = 30; 
%      alpha = 0.25, lambda = 0.80 
%      State       v(s)  true v(s) 
% ------------------------------------
%          0       0.00       0.00 
%          1      -0.89      -0.90 
%          2      -0.86      -0.80 
%          3      -0.75      -0.70 
%          4      -0.66      -0.60 
%          5      -0.50      -0.50 
%          6      -0.34      -0.40 
%          7      -0.15      -0.30 
%          8      -0.04      -0.20 
%          9       0.02      -0.10 
%         10       0.10       0.00 
%         11       0.19       0.10 
%         12       0.24       0.20 
%         13       0.28       0.30 
%         14       0.27       0.40 
%         15       0.34       0.50 
%         16       0.49       0.60 
%         17       0.68       0.70 
%         18       0.76       0.80 
%         19       0.76       0.90 
%         20       0.00       0.00 
% ------------------------------------
