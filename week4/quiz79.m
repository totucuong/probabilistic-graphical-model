clear;
load TestI0.mat;

baseMEU = OptimizeMEU(TestI0);
disp(sprintf('base MEU: %f', baseMEU));

% make D depedent on T
D = TestI0.DecisionFactors(1);
T = TestI0.RandomFactors
D.var = [D.var 11];
D.card = [D.card 