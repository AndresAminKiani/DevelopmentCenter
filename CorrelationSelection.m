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

%%
% Image space parameters
col = 120 : 250;
row = 50 : 250;
filterSize = 3;

% Image dataset selection
element = 9; 
Img{1} = imgDS_prob1_b4{element}; % select image
Img{2} = imgDS_prob1_b4{element + 9}; % select conjugate image 
correlationThreshold = .6;

% Temporal parameter
time = 12;

% NAN help
Img{1}(isnan(Img{1})) = 0;
Img{2}(isnan(Img{2})) = 0;

clear correlationBank
for side = [1 2]
    for trial = 1 : size(Img{side}, 4)
        Im{1} = imgaussfilt(Img{side}(row, col, time, 1), filterSize);
        Im{2}= imgaussfilt(Img{side}(row, col, time, trial), filterSize);
        M = fitlm(Im{2}(:), Im{1}(:));
        correlationBank{side, 1}(trial) = sqrt(M.Rsquared.Ordinary);
        trial
    end
     correlationBank{side, 2} = correlationBank{side} > correlationThreshold;
     ImgBank{side} = squeeze(imgaussfilt(Img{side}(row, col, time, correlationBank{side, 2}), filterSize));
     ImgMeanTrial(:, :, side) = nanmean(ImgBank{side}, 3);
end
disp(['Number of trials above correlation threshold: ', num2str(sum(correlationBank{1, 2})), ' and ', ...
    num2str(sum(correlationBank{2, 2})), ' for the conjugate image,'])
