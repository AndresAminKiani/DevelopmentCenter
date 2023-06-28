%% Load data B4
%   B4: 
%       imgDS_prob1_b4  - the "raw" data associated with probability 1
%       <<18x1 cell, {} Pixel_row Pixel_col time_frame trial>>
%
%        imgDS_prob2_b4  - the "raw" data associated with probability 2
%       <<18x1 cell, {} Pixel_row Pixel_col time_frame trial>>
%
%       trialDS_prob1 - the trial data associated with probability 1
%       trialDS_prob2 - the trial data associated with probability 2
load B4.mat

%% Image Selection and pre-processing ***
Im_in = imgDS_prob1_b4{9};
Im_out = imgDS_prob1_b4{18};
col = 120:250;
row = 50:250;
time = 12;
Im_in(isnan(Im_in)) = 0;
Im_out(isnan(Im_out)) = 0;
Imview{1} = imgaussfilt(Im_in(row, col, time, 1), 3);
Imview{2} = imgaussfilt(Im_in(row, col, time, 4), 3);

figure, 
subplot(2, 2, 1)
imagesc(Imview{1})
axis off
title('Trial 1')

subplot(2, 2, 3)
imagesc(Imview{2})
title('Trial 2')
axis off

subplot(2, 2, [2, 4])
scatter(Imview{2}(:), Imview{1}(:))
axis off

M = fitlm(Imview{2}(:), Imview{1}(:));
sgtitle(['Correlation: ', num2str(sqrt(M.Rsquared.Ordinary))]);
set(gca, 'FontSize', 15)

%% Generate a bank of trial by index trial correlations
Im_in = imgDS_prob1_b4{9};
clear correlationBank;
col = 120:250;
row = 50:250;
time = 12;
Im_in(isnan(Im_in)) = 0; 
Im_out(isnan(Im_out)) = 0;
for trial = 1 : size(Im_in, 4)
    Imview{1} = imgaussfilt(Im_in(row, col, time, 1), 3);
    Imview{2} = imgaussfilt(Im_in(row, col, time, trial), 3);
    M = fitlm(Imview{2}(:), Imview{1}(:));
    correlationBank(trial) = sqrt(M.Rsquared.Ordinary);
    trial
end
mean(correlationBank)
std(correlationBank)

%% Extract images subset with correlation greater than X
logidx = correlationBank > .7;
sum(logidx)
corrImgDS = squeeze(imgaussfilt(Im_in(row, col, time, logidx), 4));

figure, 
subplot(2, 1, 1)
imagesc(nanmean(corrImgDS, 3))
axis off

subplot(2, 1, 2)
corrImgDS = squeeze(imgaussfilt(Im_in(row, col, 2 : 18, logidx), 4));
plot(squeeze(nanmean(nanmean(nanmean(corrImgDS, 1), 2), 4)))
xlabel('Time (ms)')
ylabel('Amplitude')

%%
B = squeeze(nanmean(nanmean(nanmean(corrImgDS, 1), 2), 4));
Bi = nanmean(corrImgDS, 3);

%%
figure, 
subplot(3, 1, 1)
imagesc(Bi)

subplot(3, 1, 2)
imagesc(Di)

subplot(3, 1, 3)
imagesc(Di - Bi)

%%
fitlm(Di(:), Bi(:))

%%
% for col_L
%     for col_R
%         for row_U
%             for row_D
%                 col = 120:250;
%                 row = 50:250;
%                 Im_in(isnan(Im_in)) = 0;
%                 Im_out(isnan(Im_out)) = 0;
%                 Imview{1} = imgaussfilt(Im_in(row, col, 14, 1), 2);
%                 Imview{2} = imgaussfilt(Im_in(row, col, 13, 2), 2);
%             end
%         end
%     end
% end
