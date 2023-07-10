unique(Bank_e1(:, 1))

%%
Img = imgDS_prob1_b4{ 1 };

figure, 
imagesc(Img(:, :, 16, 60))

%%
k = 1;
transformationBank = [];
elements = unique(Bank_e1(:, 1));
for n = 1 : length(elements)
    elementBank = Bank_e1(Bank_e1(:, 1) == elements(n), :);
    [val, loc] = max(elementBank(:, end));
    transformationBank(k, :) = elementBank(loc, :);
    k = k + 1; clear elementBank; k
end
