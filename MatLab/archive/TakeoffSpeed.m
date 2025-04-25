%% This function was archived, because its how were calculating take-off speed, and seems to be written by GPT

function [Vtakeoff] = TakeoffSpeed(W, rho, S, CLmax)
%MAXTAKEOFFSPEED Summary of this function goes here
%   Detailed explanation goes here

% W: weight of aircraft
% rho: density of air at ground level
% S: planform area

% b: span of wing
% S: Planform area
% h: height above ground
% e: span efficiency factor
% m: mass of the plane


% W = 32.2 * m;
% L = @(V) 0.5*rho*(V^2)*S*CL0;
% e_prime = (1+(b^2)/(256*(h^2)))*e;
% D = @(V) 0.5*rho*(V^2)*S*CD0+(2*(L(V)^2))/(rho*(V^2)*S*pi*AR*e_prime);

% dt = 1;
% P = @(rho) dt*prop_eff*Pmax*((rho/rho_s)^prop_exponent);
% T = @(rho, V) P(rho)/V;

% note that W = L so the part of the equation with friction does not exist

Vstall = sqrt((2*W)/(rho*S*CLmax));

Vtakeoff = 1.1*Vstall;
end

