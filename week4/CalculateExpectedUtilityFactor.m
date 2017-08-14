% Copyright (C) Daphne Koller, Stanford University, 2012

function EUF = CalculateExpectedUtilityFactor( I )

  % Inputs: An influence diagram I with a single decision node and a single utility node.
  %         I.RandomFactors = list of factors for each random variable.  These are CPDs, with
  %              the child variable = D.var(1)
  %         I.DecisionFactors = factor for the decision node.
  %         I.UtilityFactors = list of factors representing conditional utilities.
  % Return value: A factor over the scope of the decision rule D from I that
  % gives the conditional utility given each assignment for D.var
  %
  % Note - We assume I has a single decision node and utility node.
%   D = I.DecisionFactors(1);
%   EUF = struct('var', [D.var], 'card', D.card, 'val', []);
%   assignments = IndexToAssignment(1:prod(EUF.card), EUF.card);
%   EUFVal = [];
%   for i=1:size(assignments,1)
%       % set up a decision rule corresponding to this assignment
%       D.val = zeros(1,length(D.val));
%       D.val(AssignmentToIndex(assignments(i,:), D.card)) = 1;
%       I.DecisionFactors(1) = D;
%       EUFVal = cat(2, EUFVal, SimpleCalcExpectedUtility(I));
%   end
%   EUF = struct('var', [D.var], 'card', D.card, 'val', EUFVal);
  RF = I.RandomFactors;
  D = I.DecisionFactors;
  U = I.UtilityFactors;
  PaD = D.var(1:end);
  allV = unique([RF(:).var]);
  diff = setdiff(allV, PaD);
  
  F = RF(1);
  for i=2:length(RF)
      F = FactorProduct(F, RF(i));
  end;
  F = FactorProduct(F, U);
  EUF = FactorMarginalization(F, diff);
    
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
end  
