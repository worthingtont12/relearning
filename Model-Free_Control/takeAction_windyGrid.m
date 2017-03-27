function [ next_state, reward ]= takeAction_windyGrid(state, action)

% wind for each column
wind = [0 0 0 1 1 1 2 2 1 0];

% get coordinate of the current state
    state_x = state(1);
    state_y = state(2);

switch action
        case 1 % left
            next_state = [max(state_x - 1, 1), min(state_y + wind(state_x), 7)];
        case 2 % up
            next_state = [state_x, min(state_y + 1 + wind(state_x),7) ] ;
        case 3 % right
            next_state = [min(state_x + 1, 10), min(state_y + wind(state_x),7)];
        case 4 % down
            next_state = [state_x,  max(min(state_y - 1 + wind(state_x), 7),1)];
end

reward = -1;
end
