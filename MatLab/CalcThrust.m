function Thrust = CalcThrust(conditions,power,ThrustEff)
    Thrust = ThrustEff .* power ./ conditions.U_inf;
end