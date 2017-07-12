FullI.RandomFactors = NormalizeCPDFactors(ObserveEvidence(FullI.RandomFactors, [3 2]));
FullI.DecisionFactors = NormalizeCPDFactors(ObserveEvidence(FullI.DecisionFactors, [3 2]));
SimpleCalcExpectedUtility(FullI)