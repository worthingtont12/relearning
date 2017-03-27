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

% Sarsa(0)
[Q_sarsa0, policy_sarsa0, steps_sarsa0] = ...
        SarsaLambda(stateSpace, [1,4],[8,4], @takeAction_windyGrid, ...
        initialPolicy, numIterations, gamma, alpha, 0, epsilon);
min_steps = min(steps_sarsa0);
fprintf('Sarsa(0): length of optimal path is %2d\n',min_steps)

% Sarsa(0.5)
[Q_sarsa05, policy_sarsa05, steps_sarsa05] = ...
        SarsaLambda(stateSpace, [1,4],[8,4], @takeAction_windyGrid, ...
        initialPolicy, numIterations, gamma, alpha, 0.5, epsilon);
min_steps = min(steps_sarsa05);
fprintf('Sarsa(0.5): length of optimal path is %2d\n',min_steps)

% Sarsa(0.9)
[Q_sarsa09, policy_sarsa09, steps_sarsa09] = ...
        SarsaLambda(stateSpace, [1,4],[8,4], @takeAction_windyGrid, ...
        initialPolicy, numIterations, gamma, alpha, 0.9, epsilon);
min_steps = min(steps_sarsa09);
fprintf('Sarsa(0.9): length of optimal path is %2d\n',min_steps)

% Q(0)
[Q_q0, policy_q0, steps_q0] = ...
        QLambda(stateSpace, [1,4],[8,4], @takeAction_windyGrid, ...
        initialPolicy, numIterations, gamma, alpha, 0, epsilon);
min_steps = min(steps_q0);
fprintf('Q(0): length of optimal path is %2d\n',min_steps)

% Q(0.5)
[Q_q05, policy_q05, steps_q05] = ...
        QLambda(stateSpace, [1,4],[8,4], @takeAction_windyGrid, ...
        initialPolicy, numIterations, gamma, alpha, 0.5, epsilon);
min_steps = min(steps_q05);
fprintf('Q(0.5): length of optimal path is %2d\n',min_steps)

% Q(0.9)
[Q_q09, policy_q09, steps_q09] = ...
        QLambda(stateSpace, [1,4],[8,4], @takeAction_windyGrid, ...
        initialPolicy, numIterations, gamma, alpha, 0.9, epsilon);
min_steps = min(steps_q09);
fprintf('Q(0.9): length of optimal path is %2d\n',min_steps)

% Plot episodes(y-axis) vs time steps(x-axis)
    x_sarsa0 = 1:sum(steps_sarsa0);
    y_sarsa0 = [];
    for i = 1:numIterations
        num_steps = steps_sarsa0(i);
        y_sarsa0 = [y_sarsa0, i*ones(1,num_steps)];
    end 
    
    x_sarsa05 = 1:sum(steps_sarsa05);
    y_sarsa05 = [];
    for i = 1:numIterations
        num_steps = steps_sarsa05(i);
        y_sarsa05 = [y_sarsa05, i*ones(1,num_steps)];
    end  
    
    x_sarsa09 = 1:sum(steps_sarsa09);
    y_sarsa09 = [];
    for i = 1:numIterations
        num_steps = steps_sarsa09(i);
        y_sarsa09 = [y_sarsa09, i*ones(1,num_steps)];
    end 
    
    x_q0 = 1:sum(steps_q0);
    y_q0 = [];
    for i = 1:numIterations
        num_steps = steps_q0(i);
        y_q0 = [y_q0, i*ones(1,num_steps)];
    end
    
    x_q05 = 1:sum(steps_q05);
    y_q05 = [];
    for i = 1:numIterations
        num_steps = steps_q05(i);
        y_q05 = [y_q05, i*ones(1,num_steps)];
    end
    
    x_q09 = 1:sum(steps_q09);
    y_q09 = [];
    for i = 1:numIterations
        num_steps = steps_q09(i);
        y_q09 = [y_q09, i*ones(1,num_steps)];
    end
    
    
    plot(x_sarsa0,y_sarsa0,x_sarsa05,y_sarsa05, x_sarsa09,y_sarsa09,...
        x_q0,y_q0, x_q05,y_q05,x_q09,y_q09)
    legend('Sarsa(0)','Sarsa(0.5)','Sarsa(0.9)','Q(0)','Q(0.5)','Q(0.9)','Location','northwest')
   
    xlabel('Time Steps')
    ylabel('Episodes')
    saveas(gcf,'Sarsa_vs_Q_windyGrid');