clear
%rng(123)
[X,Y,Z]= meshgrid(12:21,1:10,0:1);
stateSpace = reshape([X,Y,Z], 100, 3, 2);
stateSpace = [stateSpace(:,:,1); stateSpace(:,:,2) ; 0 0 0]; %[0 0 0] indicates the terminal state

crazyPolicy = zeros(size(stateSpace,1), 2);
crazyPolicy(:,1) = ones(size(stateSpace,1),1);
hit_states = find( stateSpace(:,1)==21 | stateSpace(:,1)==20);
crazyPolicy( hit_states,:) = repmat([0,1], length(hit_states),1);

alpha = 0;
gamma = 1;
num_episodes = 10000;
initial_v_pi = zeros(201,1);
v_pi = MCeveryVisit(stateSpace, @getEpisodes_blackjack,crazyPolicy,...
                    alpha,gamma, initial_v_pi, num_episodes);

% Plot v_pi when player has usable ace
surf(12:21,1:10,reshape(v_pi(101:200),10,10))
xlabel('Player sum')
ylabel('Dealer showing')
title_format = 'After %d episodes \n Usable ace';
title_str = sprintf(title_format,num_episodes);
title(title_str);
saveas(gcf,'v_usableAce')

% Plot v_pi when player has no usable ace
surf(12:21,1:10,reshape(v_pi(1:100),10,10))
xlabel('Player sum')
ylabel('Dealer showing')
title_format = 'After %d episodes \n No usable ace';
title_str = sprintf(title_format,num_episodes);
title(title_str);
saveas(gcf,'v_noUsableAce')
