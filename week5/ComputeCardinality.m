function [var card] = ComputeCardinality(Factors)
% this function collect variables and cardinality for a list of factors
% var will be sorted.
% INPUT: a struct array of factors
% OUTPUT:   var an array of variables
%           card an array of their cardinality
var = [];
card = [];
N=length(Factors);

for k=1:N
    % save to copy later
    oldcard = card;
    mapVar = var;
    
    % collect new variables
    var = union(var, Factors(k).var);
    [dummy mapF] = ismember(Factors(k).var, var); % a mapping between variables in Factors(i) and in var
    
    % new cardinality
    card = zeros(1, length(var));
    card(mapF) = Factors(k).card;
    
    % copy the old cardinality over
    card(mapVar) = oldcard;
end
end