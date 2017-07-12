% this is the code to verify example 23.6 in the book.
% variable names:
% market M 1
% conduct survey C 2
% survey result S 3
% found a company F 4

% P(M)
factors(1) = struct('var', [1], 'card', [3], 'val', [0.5 0.3 0.2]);

% P(C)
factors(2) = struct('var', [2], 'card', [2], 'val', [0 1]);

% P(S|M,C)
factors(3) = struct('var', [3 1 2], 'card', [4 3 2], 'val', []);
assignments = IndexToAssignment(1:prod(factors(3).card), factors(3).card);
for i=1:size(assignments,1)
    
end

% P(F|S)
factors(4) = struct('var', [4 3], 'card', [2 4], 'val', []);
