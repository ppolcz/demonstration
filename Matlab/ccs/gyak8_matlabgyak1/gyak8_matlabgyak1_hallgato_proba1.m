%% Script gyak8_matlabgyak1_hallgato_proba1
%  
%  file:   gyak8_matlabgyak1_hallgato_proba1.m
%  author: Peter Polcz <ppolcz@gmail.com> 
%  
%  Created on 2017.04.06. Thursday, 16:51:57
%
%% Linearized model around the stable equilibrium point

% model parameters
M = 0.5;
m = 0.2;
l = 1;
g = 9.8;
b = 0;

A = [
    0                     1                             0  0
    0      -(4*b)/(4*M + m)            -(3*g*m)/(4*M + m)  0
    0                     0                             0  1
    0  -(3*b)/(l*(4*M + m))  -(3*g*(M + m))/(l*(4*M + m))  0
    ];

B = [
    0
    4/(m+4*M)
    0
    3/(m+4*M)/l
    ];

C = [
    1 0 0 0
    0 0 1 0
    ];

D = [ 0 ; 0 ];

%% 1. determine the transfer function of the system

sys = ss(A,B,C,D);
H = tf(sys);

H_r = H(1);
H_phi = H(2);

%% 2. determine the impulse response of the system

[y,t] = impulse(H, 10);

% You can use the following function to simulate the behaviour of the
% inverted pendulum:
gyak8_simulate_pendulum_Pi(t,y)

%% 3. determine the step response and the DC gain of the system

step(sys)
step(H_phi,10)
dcgain(H_phi)

%%

[y,t] = step(sys,10);
gyak8_simulate_pendulum_Pi(t,y)

%% 4. determine the poles of the system
% Is the system stable, exponentially stable or unstable?

help pzmap

%% 5. determine the Bode plot of the transfer function
% Plot only for the transfer function from F to omega.
% The frequency unit set to be in Hz.
% Determine the own (or resonance) frequency (f_r) of the system.

bopts = bodeoptions;
bopts.FreqScale = 'linear';
bopts.FreqUnits = 'Hz';
bodeplot(H_phi, bopts)

[pgain, wr] = getPeakGain(H_phi);
fr = wr / (2*pi);

%% 6. Nyquist plot

help nyquist

%% 7. (a) Simulation using lsim - resonance frequency

T = 10;
t = 0:0.1:T;
u = sin(wr*t);

[y,t] = lsim(H,u,t);

gyak8_simulate_pendulum_Pi(t,y,u);

% After a while we shall notice, that the system's motion is quite
% unusual, why?

%% 7. (b) Simulation using lsim - high frequency, large amplitude

T = 20;
t = 0:0.1:T;
u = 20000990000000*sin(2*pi*5*t);

[y,t] = lsim(H,u,t);

gyak8_simulate_pendulum_Pi(t,y,u);

%% 8. Simulation using ode45

x0 = [0 0 pi/6 0]';

help ode45

% [t,x] = ???
% gyak8_simulate_pendulum_Pi(t,x)

%% 9. Controllability


%% 10. Observability


%% Nonlinear model - parameters (A)
% No friction

syms t x v phi omega

% model parameters
M = 0.5;
m = 0.2;
l = 1;
g = 9.8;
b = 0;

q = 4*(M+m) - 3*m*cos(phi)^2;

f_sym = [
    v
    (4*m*l*sin(phi)*omega^2 - 1.5*m*g*sin(2*phi) -4*b*v) / q
    omega
    3*(-m*l*sin(2*phi)*omega^2 / 2 + (M+m)*g*sin(phi) + b*cos(phi)*v) / (l*q)
    ];

g_sym = [
    0
    4*l
    0
    -3*cos(phi)
    ] / (l*q);

f_ode = matlabFunction(f_sym, 'vars', {t , [ x ; v ; phi ; omega ]});
g_ode = matlabFunction(g_sym, 'vars', {t , [ x ; v ; phi ; omega ]});

%% 11. Simulation with no input


%% 11. Simulation with large amplitude, high frequency sinusoidal signal


%% 11. Simulation with small amplitude, resonance frequency sinusoidal signal


%% Nonlinear model - parameters (B)
% With friction

syms t x v phi omega

% model parameters
M = 0.5;
m = 0.2;
l = 1;
g = 9.8;
b = 10;

q = 4*(M+m) - 3*m*cos(phi)^2;

f_sym = [
    v
    (4*m*l*sin(phi)*omega^2 - 1.5*m*g*sin(2*phi) -4*b*v) / q
    omega
    3*(-m*l*sin(2*phi)*omega^2 / 2 + (M+m)*g*sin(phi) + b*cos(phi)*v) / (l*q)
    ];

g_sym = [
    0
    4*l
    0
    -3*cos(phi)
    ] / (l*q);

f_ode = matlabFunction(f_sym, 'vars', {t , [ x ; v ; phi ; omega ]});

%% 11. Simulation


%% 12. PID controller design for a simple linear system (not pendulum)

help pidtune
help pidTuner