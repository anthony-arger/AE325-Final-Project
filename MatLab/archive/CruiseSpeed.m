function [cruise_spd] = CruiseSpeed(CL,CLmax, S, rho, W)
%CRUISESPEED Summary of this function goes here
%   Detailed explanation goes here
% S: planform area
% W: weight of the plane
Vstall = sqrt((2*W)/(rho*S*CLmax));
cruise_spd = sqrt((2*W)/(rho*S*CL));
if cruise_spd < Vstall
    display('ALERT: AIRCRAFT IS STALLING AT THIS CRUISING SPEED')
    display('REDESIGN WING')
end
end

