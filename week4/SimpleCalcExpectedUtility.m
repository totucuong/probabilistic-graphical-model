% Copyright (C) Daphne Koller, Stanford University, 2012

function EU = SimpleCalcExpectedUtility(I)

  % Inputs: An influence diagram, I (as described in the writeup).
  %         I.RandomFactors = list of factors for each random variable.  These are CPDs, with
  %              the child variable = D.var(1)
  %         I.DecisionFactors = factor for the decision node.
  %         I.UtilityFactors = list of factors representing conditional utilities.
  % Return Value: the expected utility of I
  % Given a fully instantiated influence diagram with a single utility node and decision node,
  % calculate and return the expected utility.  Note - assumes that the decision rule for the 
  % decision node is fully assigned.

  % In this function, we assume there is only one utility node.
  F = [I.RandomFactors I.DecisionFactors];
  U = I.UtilityFactors(1);
  
  % extract variables in F
  var = [];
  for i=1:length(F)
      var = cat(2, var, F(i).var);
  end
  
  % extract parents of decision node
  pad = U.var;
  
  % variable to be elimiated
  elimvar = setdiff(var, pad);
  
  % perform marginalization. Note that F marginal is still a list of
  % factors
  FMarginal = VariableElimination(F, elimvar);
  % compute expected utilities
  TmpFactors = [FMarginal U];
  tmp = TmpFactors(1);
  for i=2:length(TmpFactors)
      tmp = FactorProduct(tmp, TmpFactors(i));
  end
  EU = [sum(tmp.val)];
end
