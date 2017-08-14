clear;
load TestI0.mat;

baseMEU = OptimizeWithJointUtility(TestI0);
disp(sprintf('base MEU: %f', baseMEU));

% changing the decision rule should not change the value of baseMEU
TestI0.DecisionFactors.val = [0 0];
baseMEU = OptimizeWithJointUtility(TestI0);
disp(sprintf('base MEU: %f', baseMEU));

% make D depedent on T
D = TestI0.DecisionFactors(1);
D.var = [D.var 11];
D.card = [D.card 2];
D.val = zeros(prod(D.card),1);
TestI0.DecisionFactors = D;

% T1
TestI0.RandomFactors(10).val = [0.75, 0.25, 0.001, 0.999];
VPI1 = OptimizeWithJointUtility(TestI0) - baseMEU;
disp(sprintf('VPI(T1): \t%f', VPI1));
disp(sprintf('Money utility of T1: \t%f', ComputeMoney(VPI1)));

%T2

TestI0.RandomFactors(10).val = [0.999, 0.001, 0.25, 0.75];
VPI2 = OptimizeWithJointUtility(TestI0) - baseMEU;
disp(sprintf('VPI(T2): \t%f', VPI2));
disp(sprintf('Money utility of T2: \t%f', ComputeMoney(VPI2)));

%T3

TestI0.RandomFactors(10).val = [0.999, 0.001, 0.001, 0.999];
VPI3 = OptimizeWithJointUtility(TestI0) - baseMEU;
disp(sprintf('VPI(T3): \t%f', VPI3));
disp(sprintf('Money utility of T3 \t%f', ComputeMoney(VPI3)));


