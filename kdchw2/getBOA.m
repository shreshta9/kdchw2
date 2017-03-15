function [angle] = getBOA(params)
angle = 0;
degs = 50:4:80;
tol = deg2rad(1);
for i = 1:length(degs)
    deg = degs(i);
    rad = deg2rad(deg);
    state_initial = [0 0 rad 0];

    t0 = 0; tf = 15; h = 1e-2;
    [y] = ode4(@(t,y)cartpole_dynamics_lqr(t,y,params),t0,h,tf,state_initial');
    y = transpose(reshape(y, 4, length(y)/4));
    t = transpose(t0:h:tf); 
    finalTheta = y(end,3);
    if tol<finalTheta || isnan(finalTheta);
        angle = degs(i-1);
        break;
    end
end
end