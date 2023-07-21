transformationBankGrand = [];
transformedImagesGrand = [];

%%
B = Bank_e17;
B(1, :) = [];
k = 1;
transformationBank = [];
elements = unique(B(:, 1));
for n = 1 : length(elements)
    elementBank = B(B(:, 1) == elements(n), :);
    [val, loc] = max(elementBank(:, end));
    transformationBank(k, :) = elementBank(loc, :);
    k = k + 1; clear elementBank; k
end

transformedImages = [];
row = 50 : 250; col = 120 : 270;
for n = 1 : length(transformationBank)
    for time = 1 : 45
        F = Img(row + transformationBank(n, 2), col + transformationBank(n, 3), time, transformationBank(n, 1));
        F(isnan(F)) = 0;
        F = imrotate(F, transformationBank(n, 4), 'bilinear', 'crop');
        transformedImages(:, :, time, n) = F;
    end
    n
end

A = squeeze(transformedImages(:, :, 16, :));
transformationBankGrand = [transformationBankGrand; transformationBank];
transformedImagesGrand = cat(3, transformedImagesGrand, A);

%%
M = mean(transformedImagesGrand, 3);
figure, 
imagesc(M)
axis off

fM = imgaussfilt(M.^4, 1.5);
figure, 
imagesc(fM)
axis off

%%
figure, 
subplot(3, 1, 1)
histogram(transformationBankGrand(:,2))
xlabel('Pixels')
ylabel('Frequency')
set(gca, 'FontSize', 15)
title('Vertical Transformation')

subplot(3, 1, 2)
histogram(transformationBankGrand(:,3))
xlabel('Pixels')
ylabel('Frequency')
set(gca, 'FontSize', 15)
title('Horizontal Transformation')

subplot(3, 1, 3)
histogram(transformationBankGrand(:,4))
xlabel('Rotation Angle')
ylabel('Frequency')
set(gca, 'FontSize', 15)
title('Rotational Transformation')

%%
L = transformationBankGrand(:, end) > .3;
subTBG = transformationBankGrand(L, :);
subTIG = transformedImagesGrand(:, :, L);

%%
M = mean(subTIG, 3);
figure, 
imagesc(M)
axis off

fM = imgaussfilt(M.^2, 1.5);
figure, 
imagesc(fM)
axis off
