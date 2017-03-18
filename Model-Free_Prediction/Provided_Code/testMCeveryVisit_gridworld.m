% Initializazion (random policy)
policy = ones(15,4)*0.25;
policy(15,:)=0;

num_episodes = 1000;
alpha=0;
gamma = 1;
initial_v_pi = zeros(15,1);

[v_pi, v_pi_all] = MCeveryVisit((1:15)',@getEpisodes_gridworld,policy,alpha,gamma, initial_v_pi,num_episodes);

true_v_pi = [-14; -20; -22; -14; -18; -20;-20; -20; -20; -18; -14; -22; -20; -14; 0];

clc
fprintf('-----------------------------------\n')
fprintf('        #episodes = %d; \n',num_episodes)
fprintf('           alpha = %.2f; \n',alpha)
fprintf('%10s %10s %10s\n', 'State', 'v(s)', 'true v(s)')
fprintf('-----------------------------------\n')
fprintf('%10d %10.1f %10.1f\n', [1:15; v_pi';true_v_pi'])
fprintf('-----------------------------------\n')
% -----------------------------------
%         #episodes = 1000; 
%            alpha = 0.00; 
%      State       v(s)  true v(s)
% -----------------------------------
%          1      -15.6      -14.0
%          2      -21.2      -20.0
%          3      -20.9      -22.0
%          4      -13.9      -14.0
%          5      -19.3      -18.0
%          6      -22.2      -20.0
%          7      -22.1      -20.0
%          8      -19.7      -20.0
%          9      -20.5      -20.0
%         10      -19.7      -18.0
%         11      -15.5      -14.0
%         12      -22.5      -22.0
%         13      -19.5      -20.0
%         14      -13.1      -14.0
%         15        0.0        0.0
% -----------------------------------
