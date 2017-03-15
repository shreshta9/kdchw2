params.m = 0.1;
params.M = 1;
params.g = 9.8;
params.l = 1;

%% Forward dynamics implemented using ode45

% Linearized Dynamics
A = [0, 1, 0, 0; 0, 0, -(params.m*params.g)/params.M, 0; 0, 0, 0, 1; 0, 0, ((params.M+params.m)*params.g)/(params.l*params.M), 0];
B = [0; 1/params.M; 0; -1/(params.l*params.M)];
C = [1 0 0 0; 0 0 1 0];

% LQR Control Gains

[qxVals, qthetaVals] = meshgrid([0.1:0.1:0.3 1:10:30], [0.1:0.1:0.3 1:10:30]);
qXThetaGrid = [qxVals(:) qthetaVals(:)];
basins = zeros(size(qXThetaGrid, 1), 1);
gains = zeros(size(qXThetaGrid, 1), 4);

R = 1;
for i = 1:size(qXThetaGrid,1)
    Q = diag([qXThetaGrid(i,1) 1 qXThetaGrid(i,2) 1]);
    [K,~,~] = lqr(A,B,Q,R);
    params.K = K;
    [basin] = getBOA(params);
    basins(i) = basin;
    gains(i, :) = K;

    fprintf('Basin of Attraction for (q1:%d, q3:%d) values is %d degrees \n', qXThetaGrid(i,1), qXThetaGrid(i,2), basin)
end

maxb = max(basins);
idx = find(basins == maxb);

fprintf('Maximum Basin of Attraction is %d degrees \n', maxb)
fprintf('This maximum basin of attraction is achieved for following sets of gains : \n');
gains(idx,:)    