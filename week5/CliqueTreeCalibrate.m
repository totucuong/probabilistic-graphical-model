%CLIQUETREECALIBRATE Performs sum-product or max-product algorithm for 
%clique tree calibration.

%   P = CLIQUETREECALIBRATE(P, isMax) calibrates a given clique tree, P 
%   according to the value of isMax flag. If isMax is 1, it uses max-sum
%   message passing, otherwise uses sum-product. This function 
%   returns the clique tree where the .val for each clique in .cliqueList
%   is set to the final calibrated potentials.
%
% Copyright (C) Daphne Koller, Stanford University, 2012

function P = CliqueTreeCalibrate(P, isMax)


% Number of cliques in the tree.
N = length(P.cliqueList);

% Setting up the messages that will be passed.
% MESSAGES(i,j) represents the message going from clique i to clique j. 
MESSAGES = repmat(struct('var', [], 'card', [], 'val', []), N, N);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% We have split the coding part for this function in two chunks with
% specific comments. This will make implementation much easier.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% YOUR CODE HERE
% While there are ready cliques to pass messages between, keep passing
% messages. Use GetNextCliques to find cliques to pass messages between.
% Once you have clique i that is ready to send message to clique
% j, compute the message and put it in MESSAGES(i,j).
% Remember that you only need an upward pass and a downward pass.
%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (isMax)
    % Max-Sum Algorithm
    % transform into log space
%     for i=1:N
%         P.cliqueList(i).val = log(P.cliqueList(i).val);
%     end
%     [i j] = GetNextCliques(P, MESSAGES);
    
else
    % Sum-Product Algorithm
    [i j] = GetNextCliques(P, MESSAGES);
    while (i ~= 0)
%         disp(['passing message from', num2str(i), 'to', num2str(j)]);
        % computing temporary factor psi
        psi = P.cliqueList(i);
        nbi = find(P.edges(:,i) == 1);
        nbi = setdiff(nbi, j);
        for k=1:length(nbi)
            psi = FactorProduct(psi, MESSAGES(nbi(k),i));
        end
        
        % computing message from i to j: tauij
        sepij = intersect(P.cliqueList(i).var, P.cliqueList(j).var);
        tauij = FactorMarginalization(psi,setdiff(P.cliqueList(i).var, sepij));
        
        % normalize msg before passing to avoid underflow
        tauij.val = tauij.val / sum(tauij.val); 
        MESSAGES(i,j) = tauij;
        
        [i j] = GetNextCliques(P, MESSAGES);
    end       
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE
%
% Now the clique tree has been calibrated. 
% Compute the final potentials for the cliques and place them in P.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (isMax)
else
    for i=1:length(P.cliqueList)
    b = P.cliqueList(i);
    nb = find(P.edges(:,i) == 1);
    for k=1:length(nb)
        b = FactorProduct(b, MESSAGES(nb(k), i));
    end
    P.cliqueList(i) = b;
end
end



return

% function F = normalize(M)
%     % function to normalize a message
%     F.val = F.val ./ sum(F.val);
% end

