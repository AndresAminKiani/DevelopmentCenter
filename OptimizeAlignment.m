X = squeeze(imgDS_prob1_b4{1}(:, :, 16, :));
X(isnan(X)) = 0;

%%
trial = 56;

% figure, 
subplot(2, 1, 1)
imagesc(X(:, :, 1).^2)

subplot(2, 1, 2)
imagesc(X(:, :, trial).^2)

%%
A = B + X(:, :, trial);

% figure(2), 
subplot(2, 1, 1)
imagesc(B.^2)

subplot(2, 1, 2)
imagesc(A.^2)

%%
B = A;

%%
B = X(:, :, 1);

%%
A_1 = sum(X(:, :, 1 : 19), 3);
A_1 = imrotate(A_1, y(13), 'bilinear', 'crop');
A_1 = imtranslate(A_1, [y(1) y(2)]);

A_2 = sum(X(:, :, 20 : 29), 3);
A_2 = imrotate(A_2, y(14), 'bilinear', 'crop');
A_2 = imtranslate(A_2, [y(3) y(4)]);

A_3 = sum(X(:, :, 30 : 33), 3);
A_3 = imrotate(A_3, y(15), 'bilinear', 'crop');
A_3 = imtranslate(A_3,[y(5) y(6)]);

A_4 = sum(X(:, :, 34 : 46), 3);
A_4 = imrotate(A_4, y(16), 'bilinear', 'crop');
A_4 = imtranslate(A_4,[y(7) y(8)]);

A_5 = sum(X(:, :, 48 : 54), 3);
A_5 = imrotate(A_5, y(17), 'bilinear', 'crop');
A_5 = imtranslate(A_5, [y(9) y(10)]);

A_6 = sum(X(:, :, 56 : 68), 3);
A_6 = imrotate(A_6, y(18), 'bilinear', 'crop');
A_6 = imtranslate(A_6, [y(11) y(12)]);

filt = 3;
figure, 
subplot(2, 3, 1)
imagesc(imgaussfilt(A_1, filt))
title('1')

subplot(2, 3, 2)
imagesc(imgaussfilt(A_2, filt))
title('2')

subplot(2, 3, 3)
imagesc(imgaussfilt(A_3, filt))
title('3')

subplot(2, 3, 4)
imagesc(imgaussfilt(A_4, filt))
title('4')

subplot(2, 3, 5)
imagesc(imgaussfilt(A_5, filt))
title('5')

subplot(2, 3, 6)
imagesc(imgaussfilt(A_6, filt))
title('6')

%%
Atot = 1*A_1 + 1*A_2 + 1*A_3 + 1*A_4 + 1*A_5 + 1*A_6;
figure,
subplot(2, 1, 1)
imagesc(Atot)

subplot(2, 1, 2)
imagesc(sum(X, 3))
