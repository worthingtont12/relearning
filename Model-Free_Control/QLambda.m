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
end


