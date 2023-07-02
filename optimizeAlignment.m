trial = 1; time = 16; row = 50 : 250; col = 120 : 270; 
Img = imgDS_prob1_b4{ trial };
Img_Fixed = Img(row, col, time, trial);
figure,
imagesc(Img_Fixed);

%%
F = imrotate(Img_Fixed, -90, 'bilinear', 'crop');
figure,
subplot(2, 1, 1)
imagesc(Img_Fixed);

subplot(2, 1, 2)
imagesc(F);
fitlm(F(:), Img_Fixed(:))

%%
for trial = 1 : 16
    time = 16; row = 50 : 250; col = 120 : 270; 
    Img = imgDS_prob1_b4{ trial };
    Img_Fixed = Img(row, col, time, trial);
    subplot(4, 4, trial)
    imagesc(Img_Fixed)
end

%%
clc
clear A
element = 1; k = 1;
Img = imgDS_prob1_b4{ element };
trial = 1; time = 16; row = 50 : 250; col = 120 : 270;
Img_Fixed = Img(row, col, time, trial);
Img_Fixed(isnan(Img_Fixed)) = 0;
Img_Fixed = imgaussfilt(Img_Fixed, 4);
tic
for trial = 1 : size(Img, 4)
        for r = 1 - min(row) : 316 - max(row)
            for c = 1 - min(col) : 316 - max(col)
                for rot = -5 : 5
                    F = Img(row + r, col + c, time, trial);
                    F(isnan(F)) = 0;
                    F = imrotate(F, rot, 'bilinear', 'crop');
                    M = fitlm(F(:), Img_Fixed(:));
                    x = sqrt(M.Rsquared.Ordinary);
                    A(k, :) = [trial, r, c, rot, x];
                    k = k + 1;
                end
                disp([num2str(trial),' ',num2str(r),' ',num2str(c)])
            end
        end
end
toc

%%
time = 16; 
% Img = imgDS_prob1_b4{ 1 };
% Img_A = Img(:, :, time, 1);
% Img_B = Img(:, :, time, 20);
% 
% figure,
% subplot(2, 1, 1)
% imagesc(Img_A);
% subplot(2, 1, 2)
% imagesc(Img_B);

clc
clear Bank
element = 1; k = 1;
Img = imgDS_prob1_b4{ element };
trial = 1; time = 16; row = 50 : 250; col = 120 : 270;
Img_Fixed = Img(row, col, time, trial);
Img_Fixed(isnan(Img_Fixed)) = 0;
Img_Fixed = imgaussfilt(Img_Fixed, 4);
tic
for trial = 20
        for r = 1 - min(row) : 316 - max(row)
            for c = 1 - min(col) : 316 - max(col)
                for rot = -5 : 5
                    F = Img(row + r, col + c, time, trial);
                    F(isnan(F)) = 0;
                    F = imrotate(F, rot, 'bilinear', 'crop');
                    M = fitlm(F(:), Img_Fixed(:));
                    x = sqrt(M.Rsquared.Ordinary);
                    Bank(k, :) = [trial, r, c, rot, x];
                    k = k + 1;
                end
                disp([num2str(trial),' ',num2str(r),' ',num2str(c)])
            end
        end
end
toc

%%
time = 16; 
Img = imgDS_prob1_b4{ 1 };
Img_A = Img(:, :, time, 1);
Img_B = Img(:, :, time, 20);

figure,
subplot(2, 1, 1)
imagesc(Img_A);
subplot(2, 1, 2)
imagesc(Img_B);

%%
A
Av = Bank(:, end);
[V, L] = max(Av);

%%
F = Img(row + Bank(L, 2), col + Bank(L, 3), time, trial);
F(isnan(F)) = 0;
F = imrotate(F, Bank(L, 4), 'bilinear', 'crop');
Ff = imgaussfilt(F, 4);

figure, 
subplot(3, 1, 1)
imagesc(Img_Fixed)

subplot(3, 1, 2)
imagesc(F)

subplot(3, 1, 3)
imagesc(Ff)

%%
Av = Bank(:, end);
[V, L] = max(Av);

time = 16; trial = 1;
Img = imgDS_prob1_b4{ 1 };
ImgMain = Img(:, :, time, trial);
ImgProb = Img(:, :, time, 20);

ImgProbT = ImgProb;
ImgProbT(isnan(ImgProbT)) = 0;
ImgProbT = imtranslate(ImgProbT, [-Bank(L, 2), Bank(L, 3)]);
ImgProbT = imrotate(ImgProbT, Bank(L, 4), 'bilinear', 'crop');
ImgProbT2 = ImgProbT;
ImgProbT2(ImgProbT2 == 0) = nan;

% ImgMain ImgProb ImgProbT ImgProbT2
figure, 
subplot(4, 2, [1 2])
imagesc(ImgMain)
title('Fixed Image')
set(gca, 'FontSize', 15)
axis off

subplot(4, 2, [3 4])
imagesc(ImgProb)
title('Moving Image')
set(gca, 'FontSize', 15)
axis off

subplot(4, 2, [5 6])
imagesc(ImgProbT2)
title('Moved Image')
set(gca, 'FontSize', 15)
axis off

subplot(4, 2, 7)
A = imgaussfilt(ImgMain(row, col), 4); B =imgaussfilt(ImgProb(row, col), 4);
scatter(A(:), B(:))
M1 = fitlm(A(:), B(:));
title(['Correlation: ', num2str(sqrt(M1.Rsquared.Ordinary))])
set(gca, 'FontSize', 15)
xlabel('Fixed Image')
ylabel('Moving Image')
axis square 

subplot(4, 2, 8)
A = imgaussfilt(ImgMain(row, col), 4); B1 =imgaussfilt(ImgProbT(row, col), 4);
scatter(A(:), B1(:))
M2 = fitlm(A(:), B1(:));
title(['Correlation: ', num2str(sqrt(M2.Rsquared.Ordinary))])
xlabel('Fixed Image')
ylabel('Moved Image')
set(gca, 'FontSize', 15)
axis square

%%
Av = Bank(:, end);
[V, L] = max(Av);

time = 16; trial = 1;
Img = imgDS_prob1_b4{ 1 };
ImgMain = Img(:, :, time, trial);
ImgProb = Img(:, :, time, 20);

ImgProbT1 = ImgProb;
ImgProbT1(isnan(ImgProbT1)) = 0;
ImgProbT1 = imtranslate(ImgProbT1, [-Bank(L, 2), -2*Bank(L, 3)]);
ImgProbT1 = imrotate(ImgProbT1, Bank(L, 4), 'bilinear', 'crop');

ImgProbT = ImgProb;
ImgProbT(isnan(ImgProbT)) = 0;
ImgProbT = ImgProbT(row + Bank(L, 2), col + Bank(L, 3));
ImgProbT = imrotate(ImgProbT, Bank(L, 4), 'bilinear', 'crop');
ImgProbT2 = ImgProbT1;
ImgProbT2(ImgProbT2 == 0) = nan;

% ImgMain ImgProb ImgProbT ImgProbT2
figure, 
subplot(4, 2, [1 2])
imagesc(ImgMain)
title('Fixed Image')
set(gca, 'FontSize', 15)
axis off

subplot(4, 2, [3 4])
imagesc(ImgProb)
title('Moving Image')
set(gca, 'FontSize', 15)
axis off

subplot(4, 2, [5 6])
imagesc(ImgProbT2)
title('Moved Image')
set(gca, 'FontSize', 15)
axis off

subplot(4, 2, 7)
A = imgaussfilt(ImgMain(row, col), 4); B =imgaussfilt(ImgProb(row, col), 4);
scatter(A(:), B(:))
M1 = fitlm(A(:), B(:));
title(['Correlation: ', num2str(sqrt(M1.Rsquared.Ordinary))])
set(gca, 'FontSize', 15)
xlabel('Fixed Image')
ylabel('Moving Image')
axis square 

subplot(4, 2, 8)
A = imgaussfilt(ImgMain(row, col), 4); B1 =imgaussfilt(ImgProbT, 4);
scatter(A(:), B1(:))
M2 = fitlm(A(:), B1(:));
title(['Correlation: ', num2str(sqrt(M2.Rsquared.Ordinary))])
xlabel('Fixed Image')
ylabel('Moved Image')
set(gca, 'FontSize', 15)
axis square
