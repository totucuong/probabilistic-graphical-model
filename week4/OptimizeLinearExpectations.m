% Copyright (C) Daphne Koller, Stanford University, 2012

function [MEU OptimalDecisionRule] = OptimizeLinearExpectations( I )
  % Inputs: An influence diagram I with a single decision node and one or more utility nodes.
  %         I.RandomFactors = list of factors for each random variable.  These are CPDs, with
  %              the child variable = D.var(1)
  %         I.DecisionFactors = factor for the decision node.
  %         I.UtilityFactors = list of factors representing conditional utilities.
  % Return value: the maximum expected utility of I and an optimal decision rule 
  % (represented again as a factor) that yields that expected utility.
  % You may assume that there is a unique optimal decision.
  %
  % This is similar to OptimizeMEU except that we will have to account for
  % multiple utility factors.  We will do this by calculating the expected
  % utility factors and combining them, then optimizing with respect to that
  % combined expected utility factor.  
  MEU = [];
  OptimalDecisionRule = [];
  D = I.DecisionFactors(1);
  
  % compute expected utility factor wrt to D and each utility node
  % seperately
  mius = [];
  ITmp.RandomFactors = I.RandomFactors;
  ITmp.DecisionFactors = I.DecisionFactors;
  for i=1:length(I.UtilityFactors)
      ITmp.UtilityFactors = I.UtilityFactors(i);
      mius = cat(2, mius, CalculateExpectedUtilityFactor(ITmp));
  end
  
  % now compbine them using FactorSum
  totalMiu = mius(1);
  for i=2:length(mius)
      totalMiu = FactorSum(totalMiu,mius(i));
  end
  

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %
  % YOUR CODE HERE
  %
  % A decision rule for D assigns, for each joint assignment to D's parents, 
  % probability 1 to the best option from the EUF for that joint assignment 
  % to D's parents, and 0 otherwise.  Note that when D has no parents, it is
  % a degenerate case we can handle separately for convenience.
  %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % now we have transformed into single utility node single decision node
  miu = totalMiu;
  
   % D has no parents
   D = I.DecisionFactors(1);
   if ~hasParent(D)
       [MEU, maxidx] = max(miu.val);
       OptimalDecisionRule.var = D.var;
       OptimalDecisionRule.card = D.card;
       OptimalDecisionRule.val = zeros(D.card, 1);
       OptimalDecisionRule.val(maxidx) = 1;
   else
       [MEU, OptimalDecisionRule] = ComputeOptimalDecisionRule(miu, D.var(1));     
   end
end

function p = hasParent(D)
    if (length(D.var) == 1)
        p = false;
    else
        p = true;
    end
end



function Fnew = ReorderFactor(F, VO)
    Fnew = struct('var', VO, 'card', [], 'val', []);
    % reread factor product to learn this mapping
    % TODO write something here
end