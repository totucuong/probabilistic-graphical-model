function amount = ComputeMoney(U) 
% this function compute the amount of money correspond to an amount of 
% utility
    amount = exp(U/100) - 1;
end