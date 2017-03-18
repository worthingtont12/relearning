% Initializazion 
num_episodes = 100; 
num_runs = 30; % number of simulations
alpha=0.05;
gamma = 1;

% initial value function
initial_v_pi = zeros(7,1);
initial_v_pi(2:6) = 0.5;

% random policy
policy = zeros(7,2);
policy(2:6,:) = 0.5;

v_pi = zeros(7,num_runs); 
for i = 1:num_runs
    [v_pi_singleRun,~] = TD0((0:6)',@getEpisodes_randomWalk,policy,alpha,gamma,initial_v_pi,num_episodes);
    v_pi(:,i) = v_pi_singleRun;
end
v_pi_avg = mean(v_pi,2);

clc
fprintf('------------------------\n')
fprintf('#episodes(walks) = %d; \n',num_episodes)
fprintf('        #runs = %d; \n', num_runs)
fprintf('%10s %10s\n', 'State', 'v(s)')
fprintf('------------------------\n')
states_strings = {'A ','B ','C ','D ','E '};
for i = 1:5
    fprintf('%10s %10.2f\n', char(states_strings(i)), v_pi_avg(i+1))
end
fprintf('------------------------\n')

