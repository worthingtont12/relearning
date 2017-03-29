function [Q, policy, steps] = QLambda(stateSpace, initialStates, ...
    terminalStates, takeAction, initialPolicy, numIterations, gamma, alpha,lambda,epsilon)
% This function implements Watkins's Q(lambda) algorithm.
% Inputs: stateSapce - matrix with each row representing a state
%         initialStates - matrix containing all possible initial states
%         terminalStates - matrix containing all terminal states
%         takeAction - function that gives S' and reward for the current
%                      state-action pair
%         numIterations - number of total iterations (episodes)
%         gamma - discout factor
%         alpha - learning rate (constant for simplicity)
%         lambda - parameter in Q(lambda)
%         epsilon - parameter in epislon-greedy policy (constant for
%                   simplicity)
% Outputs: Q - matrix containing q-value for each (s,a)
%          policy - matrix containing the probabilities for taking each
%                   action at each state
%          steps - vector, stores number of steps in each episode

%%%%%%%%%%%
% Your code
%%%%%%%%%%%
% initalize policy
policy = initialPolicy;
%initalize action value function
Q = zeros(70,4);

%initalize step counter
steps = zeros(numIterations,1);

for i = 1:numIterations
    terminal = false;

    %trace
    Z = zeros(70,4);
    %initalize state
    state = initialStates;
    state_index = find(all(repmat(state,length(stateSpace),1) == stateSpace, 2));

    %choose action that uses policy derived from Q(epislon-greedy)
    %generate a random probability between 1-0
    probability =rand;

    %if probability below epsilon then pick random action
    if probability <= .1
        action = randi(length(Q(state_index,:)));
    %otherwise pick action that maximizes action value function
    else
        action = (find(Q(state_index,:) == max(Q(state_index,:))));
        if length(action) > 1
            action_index = randi(length(action));
            action = action(action_index);
        end
    end

    % for each step in episode
    while terminal == false
        %increment step counter
        steps(i) = steps(i) + 1;

        %state index
        state_index = find(all(repmat(state,length(stateSpace),1) == stateSpace, 2));

        %take action observe reward and next state

        [next_state, reward] = takeAction(state, action);
        next_state_index = find(all(repmat(next_state,length(stateSpace),1) == stateSpace, 2));

        %choose a' from using policy derived from Q(epislon-greedy)
        %if probability below epsilon then pick random action
        probability =rand;
        if probability <= .1
            next_action = randi(length(Q(next_state_index,:)));
        %otherwise pick action that maximizes action value function
        else
            next_action = (find(Q(next_state_index,:) == max(Q(next_state_index,:))));
            if length(next_action) > 1
                next_action_index = randi(length(next_action));
                next_action = next_action(next_action_index);
            end
        end

        %optimal next action
        optimal_next_action = (find(Q(next_state_index,:) == max(Q(next_state_index,:))));
        if length(optimal_next_action) > 1
            optimal_next_action_index = randi(length(optimal_next_action));
            optimal_next_action = optimal_next_action(optimal_next_action_index);
        end
        %next action value
        next_q = Q(next_state_index, optimal_next_action);
        %delta
        delta = (reward) + (gamma)*(next_q) - Q(state_index, action);

        %trace incremented
        Z(state_index, action) = Z(state_index, action) + 1;

        %for s and a
        % % Determine action value function for state
        for s = 1:length(stateSpace)
            for a = 1:length(Q(s,:))
                Q(s, a) = (Q(s, a) + ((alpha)*(delta)*(Z(s, a))));

                if next_action == optimal_next_action
                    Z(s, a) = ((gamma)*(lambda)*Z(s, a));
                else
                    Z(s, a) = 0;
                end
            end
        end

        %update policy
        for j = 1:length(stateSpace)
            action_set = Q(j,:);
            numerator = (action_set == max(action_set));
            policy(j,:) = numerator/sum(numerator);
        end

        %update state and actions
        state = next_state;
        action = next_action;

        %is state terminal?
        if state == terminalStates
            terminal = true;
        end
    end
end
end
