function [MEU OptimalDecisionRule] = ComputeOptimialDecisionRule(EUF, dvar)
% This function compute OptimalDecisionRule and the corresponding maximum
% expected utility.
% Input:    EUF = conditional expected utility
%           dvar = decision variable number
% Output:   MEU = maximum expected utility
%           OptimalDecisionRule = optimal decision rule for decision node
% Assumption: We assume we have only one decision node D.
          
% first we need to rearrange the order of variables in EUF: decision
% variable should be left-mose.
[dummy mapD] = ismember(dvar, EUF.var);
newvar = EUF.var;
newvar(1) = dvar;
newvar(mapD) = EUF.var(1);

EUF = ReorderVariable(EUF,newvar);


 % compute optimal decision rule
       OptimalDecisionRule.var = EUF.var;
       OptimalDecisionRule.card = EUF.card;
       OptimalDecisionRule.val = zeros(1, prod(OptimalDecisionRule.card));
       assignments= IndexToAssignment(1:prod(OptimalDecisionRule.card), OptimalDecisionRule.card);
       maxAssign = assignments(1, :);
       maxVal = EUF.val(1);
       MEU = 0.0;
       for i=2:size(assignments,1)
           curAssign = assignments(i,:);
           curVal = GetValueOfAssignment(EUF,curAssign);
           if any(curAssign(2:end) ~= maxAssign(2:end)) % parent assignment changes
               OptimalDecisionRule = SetValueOfAssignment(OptimalDecisionRule, maxAssign, 1);
               MEU = MEU + maxVal;
               maxVal = curVal;
               maxAssign = curAssign;
           else
               if maxVal < curVal
                   maxVal = curVal;
                   maxAssign = curAssign;
               end
           end
           if i == size(assignments,1)
               OptimalDecisionRule = SetValueOfAssignment(OptimalDecisionRule, maxAssign, 1);
               MEU = MEU + maxVal;
           end
       end 
end