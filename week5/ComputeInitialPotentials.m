%COMPUTEINITIALPOTENTIALS Sets up the cliques in the clique tree that is
%passed in as a parameter.
%
%   P = COMPUTEINITIALPOTENTIALS(C) Takes the clique tree skeleton C which is a
%   struct with three fields:
%   - nodes: cell array representing the cliques in the tree.
%   - edges: represents the adjacency matrix of the tree.
%   - factorList: represents the list of factors that were used to build
%   the tree. 
%   
%   It returns the standard form of a clique tree P that we will use through 
%   the rest of the assigment. P is struct with two fields:
%   - cliqueList: represents an array of cliques with appropriate factors 
%   from factorList assigned to each clique. Where the .val of each clique
%   is initialized to the initial potential of that clique.
%   - edges: represents the adjacency matrix of the tree. 
%
% Copyright (C) Daphne Koller, Stanford University, 2012


function P = ComputeInitialPotentials(C)

% number of cliques
N = length(C.nodes);

% initialize cluster potentials 
P.cliqueList = repmat(struct('var', [], 'card', [], 'val', []), N, 1);
P.edges = zeros(N);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE
%
% First, compute an assignment of factors from factorList to cliques. 
% Then use that assignment to initialize the cliques in cliqueList to 
% their initial potentials. 
alpha = zeros(1, length(C.factorList));
for k=1:length(alpha)
    fVar = C.factorList(k).var;
    for i=1:N
        cVar = C.nodes{i};
        if all(ismember(fVar,cVar)) && alpha(k) == 0
            alpha(k) = i;
        end
    end
end

% C.nodes is a list of cliques.
% So in your code, you should start with: P.cliqueList(i).var = C.nodes{i};
% Print out C to get a better understanding of its structure.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P.edges = C.edges;

% setup cardinality
V = unique([C.factorList(:).var]);
Card = zeros(1, length(V));
for i=1:length(V)
    for j=1:length(C.factorList)
        if (~isempty(find(C.factorList(j).var == i)))
            Card(i) = C.factorList(j).card(find(C.factorList(j).var == i));
        end
    end
end

% setup initial cliqueList
for i=1:N
    P.cliqueList(i).var = C.nodes{i};
    P.cliqueList(i).card = Card(P.cliqueList(i).var);
    P.cliqueList(i).val = ones(1,prod(P.cliqueList(i).card));
end

% compute cliqueList value entries
for i=1:N
    ids = find(alpha == i);
    if (length(ids) > 0)
        % multiply factors to get intial belief at each cliques
        f = C.factorList(ids(1));
        for k=2:length(ids)
            f = FactorProduct(f,C.factorList(ids((k))));
        end
        % we need to take care of the difference in variable order
        assignments = IndexToAssignment(1:prod(P.cliqueList(i).card), P.cliqueList(i).card);
        [dummy mapf] = ismember(f.var, P.cliqueList(i).var);
        indexF = AssignmentToIndex(assignments(:, mapf), f.card);
        P.cliqueList(i).val = f.val(indexF);
    end
end

end

