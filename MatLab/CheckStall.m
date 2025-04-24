function [isStalling,Vstall] = CheckStall(cond,Aero, S, W)
% S: planform area
% W: weight of the plane
Vstall = sqrt((2*W)/(cond.rho*S*Aero.C_l_max));
% cruise_spd = sqrt((2*W)/(cond.rho*S*Aero.C_l));
if cond.U_inf < Vstall
    display('ALERT: AIRCRAFT IS STALLING AT THIS CRUISING SPEED')
    display('REDESIGN WING')
    isStalling = true;
else
    isStalling = false;
end
end