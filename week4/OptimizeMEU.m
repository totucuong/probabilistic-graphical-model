% Copyright (C) Daphne Koller, Stanford University, 2012

function [MEU OptimalDecisionRule] = OptimizeMEU( I )

  % Inputs: An influence diagram I with a single decision node and a single utility node.
  %         I.RandomFactors = list of factors for each random variable.  These are CPDs, with
  %              the child variable = D.var(1)
  %         I.DecisionFactors = factor for the decision node.
  %         I.UtilityFactors = list of factors representing conditional utilities.
  % Return value: the maximum expected utility of I and an optimal decision rule 
  % (represented again as a factor) that yields that expected utility.
  
  % We assume I has a single decision node.
  % You may assume that there is a unique optimal decision.
  D = I.DecisionFactors(1);

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %
  % YOUR CODE HERE...
  % 
  % Some other information that might be useful for some implementations
  % (note that there are multiple ways to implement this):
  % 1.  It is probably easiest to think of two cases - D has parents and D 
  %     has no parents.
  % 2.  You may find the Matlab/Octave function setdiff useful.
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
  OptimalDecisionRule = struct('var', [], 'card', [], 'val', []);
    
% the conditional expected utility wrt to decision D

    miu = CalculateExpectedUtilityFactor(I);
   % D has no parents
   if ~hasParent(D)
       [MEU maxidx] = max(miu.val);
       OptimalDecisionRule.var = D.var;
       OptimalDecisionRule.card = D.card;
       OptimalDecisionRule.val = zeros(D.card, 1);
       OptimalDecisionRule.val(maxidx) = 1;
   else
       [MEU OptimalDecisionRule] = ComputeOptimalDecisionRule(miu, D.var(1));
   end
end

% function vars = collectChanceVariables(I)
%     vars = [];
%     for i=1:length(I.RandomFactors);
%        vars = cat(2, vars, I.RandomFactors(i).var(i));
%     end
%     vars = unique(vars);
% end

function p = hasParent(D)
    if (length(D.var) == 1)
        p = false;
    else
        p = true;
    end
end
