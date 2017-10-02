% let's try to experiment with reduced factors by observing some evidence

F(1) = struct('var', [1,2], 'card', [2, 2], 'val', [0.4 0.6 0.7 0.3]);
F(1) = ObserveEvidence(F(1), [1 1]);