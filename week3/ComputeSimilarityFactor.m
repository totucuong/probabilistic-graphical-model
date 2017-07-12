function factor = ComputeSimilarityFactor (images, K, i, j)
% This function computes the similarity factor between two character images
% in one word --- which characters is given by indices i and j (a
% description of how the factor should be computed is given below).
%
% Input:
%   images: A struct array of character images from one word.
%   K: The alphabet size.
%   i,j: The scope of that factor. That is, you should construct a factor
%     between characters i and j in the images array.
%
% Output:
%   factor: The similarity factor between these two characters. For any
%     assignment C_i != C_j, the factor value should be one. For any
%     assignment C_i == C_j, the factor value should be
%     ImageSimilarity(I_i, I_j) --- ie, the computed value given by
%     ImageSimilarity.m on the two images.
%
% Copyright (C) Daphne Koller, Stanford University, 2012

factor = struct('var', [], 'card', [], 'val', []);

% Your code here:
factor.var = [i j];
factor.card = [K K];
assignments = IndexToAssignment(1:prod(factor.card), factor.card);
val = [];
for k=1:size(assignments,1)
    c_i = assignments(k,1);
    c_j = assignments(k,2);
    if c_i ~= c_j
        val = [val; 1];
    else
        val = [val; ImageSimilarity(images(i).img, images(j).img)];
    end
end
factor.val = val;
end

