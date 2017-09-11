% Sampling Methods PA Quiz
rand('seed', 1);



% Question 1: What effect does the initial assignment have on the accuracy
% of Gibbs sampling? 
% Answer: By plotting the estimated marginals and compare them to the exact
% marginals to decide the accuracy.
[toy_network toy_factors] = ConstructToyNetwork(1,0.1);
toy_evidence = zeros(1,length(toy_network.names));

% Perform exact inference
ExactM = ComputeExactMarginalsBP(toy_factors, toy_evidence, 0);


A0 = ones(1,length(toy_network.names));
[M, samples] = MCMCInference(toy_network, toy_factors, toy_evidence, 'Gibbs', 1000, 100,1,A0);
samples_list = {samples};
A0 = 2*A0;
[M, samples] = MCMCInference(toy_network, toy_factors, toy_evidence, 'Gibbs', 1000, 100,1,A0);
samples_list{end+1} = samples;
vis_vars = [3];
    VisualizeMCMCMarginals(samples_list, vis_vars, toy_network.card(vis_vars), toy_factors, ...
      300, ExactM(vis_vars),'Gibbs');
disp('Display result of Gibbs sampling with intial states (1,...1)');
disp(['Hit enter to continue']);
pause;



% 
% % MCMC Inference
% transition_names = {'Gibbs', 'MHUniform', 'MHGibbs', 'MHSwendsenWang1', 'MHSwendsenWang2'};
% 
% % Construct the toy network
% [toy_network, toy_factors] = ConstructToyNetwork(0.5, 0.5);
% toy_evidence = zeros(1, length(toy_network.names));
% 
% % Perform exact inference
% ExactM = ComputeExactMarginalsBP(toy_factors, toy_evidence, 0);
% 
% 
% % a list of samples from different Markov Chain runs. sample{i} for ith
% % chain
% samples_list = {};
% for i=1:2
%     [M, samples] = MCMCInference(toy_network, toy_factors, toy_evidence, 'Gibbs', 500 ,300, 0, A0);
%     samples_list{i} = samples;
% end
% 
% 
% vis_vars = [2, 6, 13];
% vis_card = toy_network.card(vis_vars);
% VisualizeMCMCMarginals(samples_list, vis_vars, vis_card, toy_factors, 30, ExactM(vis_vars), transition_names{1});
% 

%Quiz Q1
% starting state with all 1
% A0 = ones(1,length(G.names));
%  % perform inference using gibbs sampling
% [M, all_samples] = MCMCInference(G, F, [], 'Gibbs', 500 ,300, 0, A0);
% all_samples
% M

% A0 = 2*ones(1,length(G.names));
%  % perform inference using gibbs sampling
% [M, all_samples] = MCMCInference(G, F, [], 'Gibbs', 100 ,300, 0, A0);
% all_samples
% M

% <cuong> answers: The initial state has a significant impact on the result of our sampling 
% as Gibbs will never switch variables because the pairwise potentials enforce
% strong agreement so we are in a local optima.

%Quiz Q2