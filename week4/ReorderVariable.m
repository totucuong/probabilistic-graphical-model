function FO = ReorderVariable(F,VO)
% This function reorder a factor acccording to a new variable order
% Inputs:   F = a factor
%           VO = a new variable order
% Ouput:    The new factor with new variable order

if isempty(VO), FO=F; return; end;

sortedVO = sort(VO);
sortedV = sort(F.var);

if length(sortedVO) ~= length(sortedV), FO = F; return; end;
if (any(sortedVO ~= sortedV)), FO = F; return; end;

FO = struct('var', [], 'card', [], 'val', []);
FO.var = VO;

% mapping between FO.var and F.var
[dummy mapFOVar] = ismember(FO.var, F.var);
FO.card = F.card(mapFOVar);
FO.val = zeros(prod(FO.card),1);
assignments = IndexToAssignment(1:prod(FO.card), FO.card);
for i=1:size(assignments,1)
    FO.val(i) = GetValueOfAssignment(F, assignments(i,:), VO);
end

end