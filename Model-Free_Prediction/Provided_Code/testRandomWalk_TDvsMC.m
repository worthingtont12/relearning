clear
rng(1000)

% Initializazion (random policy)
policy = zeros(7,2);
policy(2:6,:) = 0.5;

gamma = 1;

num_episodes = 100;
total_runs = 100;
true_v = [1/6; 2/6; 3/6; 4/6; 5/6;]; % true values for all non-terminal states
initial_v_pi = [0; 0.5; 0.5; 0.5; 0.5; 0.5; 0];

TD_alpha = [0.05 0.1 0.15];
MC_alpha = [0.01 0.02 0.03 0.04];
alpha = [TD_alpha, MC_alpha];
num_alpha = length(alpha);
legend_string = cell(num_alpha,1);
RMS = zeros(num_episodes,num_alpha);
tic
for i = 1: num_alpha
    v_pi_all = zeros(7,num_episodes,total_runs);
    if ismember(alpha(i),TD_alpha) % run TD        
        for j = 1:total_runs
            [~,v_pi_all(:,:,j)] = TD0((0:6)',@getEpisodes_randomWalk,policy,alpha(i),gamma,initial_v_pi,num_episodes); 
        end
        legend_string{i} = strcat('TD,alpha=',num2str(alpha(i)));
    else
        for j = 1:total_runs
            [~,v_pi_all(:,:,j)] = MCeveryVisit((0:6)',@getEpisodes_randomWalk,policy,alpha(i),gamma,initial_v_pi,num_episodes); 
        legend_string{i} = strcat('MC,alpha=',num2str(alpha(i)));
        end
    end
    
    deviation = v_pi_all(2:6,:,:) - repmat(true_v,[1,num_episodes,total_runs]);
    squared_error = deviation.^2 ;
    rms = sqrt(mean(squared_error,1));
    RMS(:,i) =  mean(rms,3); %average over all runs
end
toc
plot(RMS)
xlabel('Walks / Episodes')
ylabel('RMS')
legend(legend_string)
saveas(gcf,'randomWalk_TDvsMC')
