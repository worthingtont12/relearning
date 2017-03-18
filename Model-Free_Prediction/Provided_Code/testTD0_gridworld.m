% Initializazion (random policy)
policy = ones(15,4)*0.25;
policy(15,:)=0;

num_episodes = 1000;
alpha=0.05;
gamma = 1;

initial_v_pi = zeros(15,1);

rng(1234)

v_pi = TD0((1:15)',@getEpisodes_gridworld,policy, alpha,gamma,initial_v_pi,num_episodes);


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
%            alpha = 0.05;
%      State       v(s)  true v(s)
% -----------------------------------
%          1      -13.1      -14.0
%          2      -19.6      -20.0
%          3      -21.8      -22.0
%          4      -13.7      -14.0
%          5      -17.9      -18.0
%          6      -19.4      -20.0
%          7      -19.9      -20.0
%          8      -19.3      -20.0
%          9      -19.3      -20.0
%         10      -16.7      -18.0
%         11      -15.1      -14.0
%         12      -20.8      -22.0
%         13      -18.7      -20.0
%         14      -11.5      -14.0
%         15        0.0        0.0
% -----------------------------------
