function [statesFromEpisodes, actionsFromEpisodes, rewardsFromEpisodes]...
             = getEpisodes_blackjack(stateSpace, policy, num_episodes)
% This function generates episodes for the blakjack example under a given policy
% Initialization the outputs
statesFromEpisodes = cell(num_episodes,1); % a cell array
actionsFromEpisodes = cell(num_episodes,1);
rewardsFromEpisodes = cell(num_episodes,1);
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
policy = crazyPolicy
num_states = size(stateSpace,1);


for i = 1:num_episodes

    playerSum = 0;
    playerUsableAce = false; % no (usable) ace to begin with
    dealerUsableAce = false;

    %initialize player's cards
    numAce = 0;
    while playerSum <12; % always hit
        card = getCard();
        if card == 1;
            numAce = numAce + 1;
            card = 11; % count ace as eleven initially
            playerUsableAce = true;
        end
        playerSum = playerSum + card;
    end

    if playerSum > 21 % must have at least one ace
        playerSum = playerSum - 10;
        if numAce == 1  %can't use ace as 11 anymore
            playerUsableAce = false;
        end
    end

    % initialize dealer's cards
    dealerCard = getCard();
    dealerCardHidden = getCard();
    if dealerCard == 1 && dealerCardHidden ~=1
        dealerSum = 11 + dealerCardHidden;
        dealerUsableAce = true;
    elseif dealerCard ~= 1 && dealerCardHidden == 1
        dealerSum = dealerCard + 11;
        dealerUsableAce = true;
    elseif dealerCard == 1 && dealerCardHidden == 1
        dealerSum = 11 + 1;
        dealerUsableAce = true;
    else
        dealerSum = dealerCard + dealerCardHidden;
    end

    current_state = [playerSum,dealerCard,playerUsableAce];
    states = current_state;
    actions = [];
    rewards = [];
    playerBusted = false;


    % Let's play!!

    % player's turn
    while true
        current_state_index = find(all (repmat(current_state,num_states,1)==stateSpace,2));
        probabilities = policy(current_state_index,:);
        action = randsample(2,1,true,probabilities);
        actions = [actions; action];
        if action == 2 % stand
            %current_state = [playerSum,dealerCard,playerUsableAce];
            current_state = [0,0,0]; % terminal state
            states = [states; current_state];
            break;
        else
            %hit
            playerSum = playerSum + getCard();
            if playerSum > 21
                if playerUsableAce == true
                    playerSum = playerSum - 10;
                    playerUsableAce = false;
                    %reward = 0;
                    rewards = [rewards; 0];
                    current_state = [playerSum,dealerCard,playerUsableAce];
                else
                    %busted
                    %reward = -1;
                    rewards = [rewards; -1];
                    playerBusted = true;
                    %current_state = [playerSum,dealerCard,playerUsableAce];
                    current_state = [0,0,0]; %terminal state
                    states = [states; current_state];
                    break
                end
            else
                %reward = 0;
                rewards = [rewards; 0];
                current_state = [playerSum,dealerCard,playerUsableAce];
            end
        states = [states; current_state];
        end
    end

    if playerBusted
        statesFromEpisodes{i} = states;
        actionsFromEpisodes{i} = actions;
        rewardsFromEpisodes{i} = rewards;
        continue
    end

    % dealer's turn
    while true
        while dealerSum < 17
            dealerSum = dealerSum + getCard();
        end
        if dealerSum > 21
            if dealerUsableAce == true
                dealersum = dealerSum -10;
                dealerUsableAce = false;
            else
                rewards= [rewards; 1];
                break
            end
        elseif dealerSum >= 17
            if playerSum > dealerSum
                rewards = [ rewards; 1];
            elseif playerSum == dealerSum
                rewards = [rewards; 0];
            else
                 rewards = [rewards; -1];
            end
            break
        end
    end

 statesFromEpisodes{i} = states;
 actionsFromEpisodes{i} = actions;
 rewardsFromEpisodes{i} = rewards;
end
end

function newCard = getCard()
    w = 1/13*ones(10,1);
    w(end) = 4/13;
    newCard = randsample(1:10,1,true,w);
end
