M = 1;
m = 0.1;
g = 9.8;
L = 1;

A = [0      1              0           0;
     0 0  -m*g/M   0;
     0      0              0           1;
     0 0       -(M+m)*g/(L*M)  0];
B = [     0;
     1/M;
          0;
        1/(L*M)];
C = [1 0 0 0;
     0 0 1 0];
D = [0;
     0];

states = {'x' 'x_dot' 'phi' 'phi_dot'};
inputs = {'u'};
outputs = {'x'; 'phi'};

sys_ss = ss(A,B,C,D,'statename',states,'inputname',inputs,'outputname',outputs)