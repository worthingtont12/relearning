clear
row = 1:7;
column = 1:10;
[X,Y] = meshgrid(column,row);
stateSpace = reshape([X,Y],70,2);

gamma = 1;
epsilon = 0.1;
alpha = 0.5;

numIterations = 170;
initialPolicy = 0.25 * ones(70,4);

% Sarsa(0.5)
[Q_sarsa05, policy_sarsa05, steps_sarsa05] = ...
        SarsaLambda(stateSpace, [1,4],[8,4], @takeAction_windyGrid, ...
        initialPolicy, numIterations, gamma, alpha, 0.5, epsilon);

min_steps = min(steps_sarsa05);
fprintf('Sarsa(0.5): length of optimal path is %2d\n',min_steps)

% Plot episodes(y-axis) vs time steps(x-axis)
x_sarsa05 = 1:sum(steps_sarsa05);
y_sarsa05 = [];
for i = 1:numIterations
    num_steps = steps_sarsa05(i);
    y_sarsa05 = [y_sarsa05, i*ones(1,num_steps)];
end

plot(x_sarsa05,y_sarsa05)
xlabel('Time Steps')
ylabel('Episodes')
title('Sarsa(0.5)')
