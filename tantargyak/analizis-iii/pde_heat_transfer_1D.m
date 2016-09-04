function pde_heat_transfer_1D
%% 
%  
%  file:   pde_heat_transfer_1D.m
%  author: Polcz Péter <ppolcz@gmail.com> 
%  
%  Created on 2016.09.02. Friday, 13:11:38
%

%% PDEX1  Example 1 for PDEPE
%   This is a simple example with an analytical solution that illustrates
%   the straightforward formulation, computation, and plotting of the solution
%   of a single PDE.
%
%   In the form expected by PDEPE, the single PDE is
%
%   [pi^2] .*  D_ [u] =  D_ [   Du/Dx   ] +      [0]
%              Dt        Dx
%    ----         ---       -------------    -------------
%     c            u        f(x,t,u,Du/Dx)   s(x,t,u,Du/Dx)
%
%   The equation is to hold on an interval 0 <= x <= 1 for times t >= 0.
%   There is an analytical solution u(x,t) = exp(-t)*sin(pi*x). Boundary
%   conditions are specified so that it will be the solution of the initial-
%   boundary value problem.  Obviously the initial values are sin(pi*x).
%   Two kinds of boundary conditions are chosen so as to show how they
%   appear in the form expected by the solver.  The left bc is u(0,t) = 0:
%
%     [u]    +     [0] .* [       Du/Dx          ] = [0]
%
%     ---          ---    ------------------------   ---
%   p(0,t,u)      q(0,t)        f(0,t,u,Du/Dx)        0
%
%   The right bc is taken to be pi*exp(-t) + Du/Dx(1,t) = 0:
%
%   [ pi*exp(-t) ] + [1] .* [   Du/Dx    ] = [0]
%
%   --------------   ---    --------------   ---
%      p(1,t,u)     q(1,t)   f(1,t,u,Du/Dx)   0
%
%   The problem is coded in subfunctions PDEX1PDE, PDEX1IC, and PDEX1BC.
%
%   See also PDEPE, FUNCTION_HANDLE.

%   Lawrence F. Shampine and Jacek Kierzenka
%   Copyright 1984-2014 The MathWorks, Inc.

%% 
m = 0;
x = linspace(0,1,50);
t = linspace(0,2,100);

sol = pdepe(m,@pdefun,@pdeic,@pdebc,x,t);
% Extract the first solution component as u.  This is not necessary
% for a single equation, but makes a point about the form of the output.
u = sol(:,:,1);

% A surface plot is often a good way to study a solution.
figure;
surf(x,t,u);
title('Numerical solution computed with 20 mesh points.');
xlabel('Distance x');
ylabel('Time t');

figure;
surf(x,t,exp(-t)'*sin(pi*x));
title('True solution plotted with 20 mesh points.');
xlabel('Distance x');
ylabel('Time t');

% A solution profile can also be illuminating.
figure;
plot(x,u(end,:),'o',x,exp(-t(end))*sin(pi*x));
title('Solutions at t = 2.');
legend('Numerical, 20 mesh points','Analytical', 'Location', 'NorthEast');
xlabel('Distance x');
ylabel('u(x,2)');

function [c,f,s] = pdefun(x,t,u,DuDx)
%%
c = pi^2;
f = DuDx;
s = 0;


function u0 = pdeic(x)
%%
% u0 = sin(x-pi+1);
u0 = 1;

function [pl,ql,pr,qr] = pdebc(xl,ul,xr,ur,t)
%%
pl = ul;
ql = 0;
pr = pi * exp(-t);
qr = 1;

