function [Range] = RangeCalc(W,Ps,conditions)
    %at cruise
    C = 0.46; %lbs/hp-h
    conditions.U_inf = conditions.U_inf .* 2.237;
    Range = (conditions.U_inf * W.Wi / (Ps*4*C) ) * log(W.Wi/W.Wf);

end