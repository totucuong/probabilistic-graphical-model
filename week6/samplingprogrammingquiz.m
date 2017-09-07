[G, F] = ConstructToyNetwork(1,0.1);
nIteration = 500;

% starting state with all 1
A0 = ones(1,length(G.names));
 % perform inference using gibbs sampling
[M, all_samples] = MCMCInference(G, F, [], 'Gibbs', 100 ,300, 0, A0);
