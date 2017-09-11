% Sampling Methods PA Quiz
rand('seed', 1);
[toy_network toy_factors] = ConstructToyNetwork(1,0.2);
toy_evidence = zeros(1,length(toy_network.names));

% Perform exact inference
ExactM = ComputeExactMarginalsBP(toy_factors, toy_evidence, 0);

% MCMC Inference
% transition_names = {'Gibbs', 'MHUniform','MHSwendsenWang1', 'MHSwendsenWang2'};
transition_names = {'Gibbs'}
% intial states
A0 = 2*ones(1,length(toy_network.names));

samples_list = {};
for i=1:length(transition_names)
    tname = transition_names{i};
    [M, samples] = MCMCInference(toy_network, toy_factors, toy_evidence, tname, 1000, 100,1,A0);
    samples_list{end + 1} = samples;
    
    % observe variable 3 (pixel 3)
    vis_vars = [3];
    
    % visualize estimation of marginal of variable vis_vars
    VisualizeMCMCMarginals(samples_list, vis_vars, toy_network.card(vis_vars), toy_factors, ...
      300, ExactM(vis_vars),tname);
    disp(['Display result of ', tname, ' sampling with intial states (1,...1)']);
    disp(['Hit enter to continue']);
end