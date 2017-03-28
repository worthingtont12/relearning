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

% Q(0.5)
[Q_q05, policy_q05, steps_q05] = ...
        QLambda(stateSpace, [1,4],[8,4], @takeAction_windyGrid, ...
        initialPolicy, numIterations, gamma, alpha, 0.9, epsilon);

min_steps = min(steps_q05);
fprintf('Q(0.5): length of optimal path is %2d\n',min_steps)


x_q05 = 1:sum(steps_q05);
y_q05 = [];
for i = 1:numIterations
    num_steps = steps_q05(i);
    y_q05 = [y_q05, i*ones(1,num_steps)];
end

plot(x_q05,y_q05)
xlabel('Time Steps')
ylabel('Episodes')
title('Q(0.5)')
