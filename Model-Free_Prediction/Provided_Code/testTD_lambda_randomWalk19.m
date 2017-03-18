rng(123)
% Initializazion
num_episodes = 10;
num_runs = 30; % number of simulations
alpha=0.25;
gamma = 1;
lambda = 0.8;

% initial value function
initial_v_pi = zeros(21,1);

v_pi = zeros(21,num_runs);
for i = 1:num_runs
    [v_pi_singleRun,~] = TD_lambda((0:20)',@getEpisodes_randomWalk19,[],alpha,gamma,initial_v_pi,num_episodes,lambda);
    %[v_pi_singleRun,~] = TD0((0:20)',@getEpisodes_randomWalk19,policy,alpha,gamma,initial_v_pi,num_episodes);
    v_pi(:,i) = v_pi_singleRun;
end
v_pi_avg = mean(v_pi,2);
true_v_pi = ((-20:2:20)/20)';
true_v_pi(1) = 0;
true_v_pi(end) = 0;

clc
fprintf('------------------------------------\n')
fprintf(' #episodes(walks) = %d; #runs = %d; \n',num_episodes,num_runs)
fprintf('     alpha = %.2f, lambda = %.2f \n', alpha,lambda)
fprintf('%10s %10s %10s \n', 'State', 'v(s)','true v(s)')
fprintf('------------------------------------\n')
fprintf('%10d %10.2f %10.2f \n', [0:20; v_pi_avg';true_v_pi'])
fprintf('------------------------------------\n')

plot(1:19,[v_pi_avg(2:20)';true_v_pi(2:20)'],'.')
legend({'v','true v'},'Location','Northwest')
xlabel('state')
ylabel('value')
%Backward Td lambda
% ------------------------------------
%  #episodes(walks) = 10; #runs = 30;
%      alpha = 0.25, lambda = 0.80
%      State       v(s)  true v(s)
% ------------------------------------
%          0       0.00       0.00
%          1       0.00      -0.90
%          2      -0.49      -0.80
%          3      -0.56      -0.70
%          4      -0.57      -0.60
%          5      -0.60      -0.50
%          6      -0.47      -0.40
%          7      -0.24      -0.30
%          8      -0.13      -0.20
%          9      -0.04      -0.10
%         10       0.00       0.00
%         11       0.02       0.10
%         12       0.09       0.20
%         13       0.18       0.30
%         14       0.31       0.40
%         15       0.53       0.50
%         16       0.35       0.60
%         17       0.51       0.70
%         18       0.58       0.80
%         19       0.00       0.90
%         20       0.00       0.00
% ------------------------------------
