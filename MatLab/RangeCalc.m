function [range] = RangeCalc(W,Ps,conditions)
%at cruise
C = 0.46 %lbs/hp-h
 Range = (conditions.U_inf*W.Wi/(Ps*4*C))*log(W.Wi/W.Wf)
end