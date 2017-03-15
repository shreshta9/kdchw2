M = 1;
m = 0.1;
b = 0.1;
l = 1;
g = 9.8;

I = m*(l^2)/3;

q = (M+m)*(I+m*l^2)-(m*l)^2;
s = tf('s');
P_pend = (m*l*s/q)/(s^3 + (b*(I + m*l^2))*s^2/q - ((M + m)*m*g*l)*s/q - b*m*g*l/q);

Kp = 100;
Ki = 1;
Kd = 20;
C = pid(Kp,Ki,Kd);
T = feedback(P_pend,C);

t1=0:0.01:10;
impulse(T,t1)
axis([0, 2.5, -0.2, 0.2]);
title('Pendulum Position due to Impulse under PID Control: Kp = 100, Ki = 1, Kd = 20');
%{
P_cart = (((I+m*l^2)/q)*s^2 - (m*g*l/q))/(s^4 + (b*(I + m*l^2))*s^3/q - ((M + m)*m*g*l)*s^2/q - b*m*g*l*s/q);
T2 = feedback(1,P_pend*C)*P_cart;
t2 = 0:0.01:5;
impulse(T2, t2);
title('Cart Position to an Impulse under PID Control: Kp = 100, Ki = 1, Kd = 20');
%}