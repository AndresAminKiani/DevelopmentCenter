%% Load data B4
%   B4: 
%       imgDS_prob1_b4  - the "raw" data associated with probability 1
%       <<18x1 cell, {} Pixel_row Pixel_col time_frame>>
%
%        imgDS_prob2_b4  - the "raw" data associated with probability 2
%       <<18x1 cell, {} Pixel_row Pixel_col time_frame>>
%
%       trialDS_prob1 - the trial data associated with probability 1
%       trialDS_prob2 - the trial data associated with probability 2
load B4.mat

%% Image Selection and pre-processing ***
Im_in = imgDS_prob1_b4{9};
col = 120:250;
row = 50:250;
time = 12;
Im_in(isnan(Im_in)) = 0;
Im_out(isnan(Im_out)) = 0;
Imview{1} = imgaussfilt(Im_in(row, col, time, 1), 4);
Imview{2} = imgaussfilt(Im_in(row, col, time, 100), 4);

%% Generate a bank of trial by index trial correlations
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
