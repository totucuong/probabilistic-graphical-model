%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test case 4 - Add another utility node that is a function of D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X1 = struct('var', [1], 'card', [2], 'val', [7, 3]);
X1.val = X1.val / sum(X1.val);
D = struct('var', [2,1], 'card', [2,2], 'val', [1,0,0,1]);
X3 = struct('var', [3,1,2], 'card', [2,2,2], 'val', [4 4 1 1 1 1 4 4]);
X3 = CPDFromFactor(X3,3);

% U is now a function of 3 instead of 2.
U1 = struct('var', [2,3], 'card', [2, 2], 'val', [10, 1, 5, 1]);
U2 = struct('var', [2], 'card', [2], 'val', [1, 10]);

I4.RandomFactors = [X1 X3];
I4.DecisionFactors = D;
I4.UtilityFactors = [U1 U2];

% [meu optdr] = OptimizeWithJointUtility(I4)
[meu optdr] = OptimizeLinearExpectations(I4)
meu

% OUTPUT
% meu => 11
% PrintFactor(optdr) => 
% 1	2	
% 1	1	0.000000
% 2	1	0.000000
% 1	2	1.000000
% 2	2	1.000000