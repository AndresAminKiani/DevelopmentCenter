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
filterSize = 4;

% Image dataset selection
element = 9; 
Img{1} = imgDS_prob1_b4{element}; % select image
Img{2} = imgDS_prob1_b4{element + 9}; % select conjugate image 
correlationThreshold = .7;

% Temporal parameter
time = 14;

% NAN help
Img{1}(isnan(Img{1})) = 0;
Img{2}(isnan(Img{2})) = 0;

clear correlationBank Im ImgBank
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

A = ImgMeanTrial(:, :, 1);
B = ImgMeanTrial(:, :, 2);
scatter(B(:), A(:))
fitlm(B(:), A(:))
axis equal

%%
col = 120 : 250;
row = 50 : 250;
filterSize = 4;

clear ElementBankTotal ImgMeanTrial
for element = [1, 2, 3, 4, 5, 6, 7, 9] 
    % Image dataset selection
    Img{1} = imgDS_prob1_b4{element}; % select image
    Img{2} = imgDS_prob1_b4{element + 9}; % select conjugate image 
    correlationThreshold = .5;
    
    % Temporal parameter
    time = 14;
    
    % NAN help
    Img{1}(isnan(Img{1})) = 0;
    Img{2}(isnan(Img{2})) = 0;
    
    clear correlationBank Im ImgBank
    for side = [1 2]
        for trial = 1 : size(Img{side}, 4)
            Im{1} = imgaussfilt(Img{side}(row, col, time, 1), filterSize);
            Im{2}= imgaussfilt(Img{side}(row, col, time, trial), filterSize);
            M = fitlm(Im{2}(:), Im{1}(:));
            correlationBank{side, 1}(trial) = sqrt(M.Rsquared.Ordinary);
            disp(['Element: ', num2str(element), ' Trial: ', num2str(trial)])
        end
         correlationBank{side, 2} = correlationBank{side} > correlationThreshold;
         ImgBank{side} = squeeze(imgaussfilt(Img{side}(row, col, time, correlationBank{side, 2}), filterSize));
         ImgMeanTrial(:, :, side) = nanmean(ImgBank{side}, 3);
         ElementBankTotal{side, element} = ImgBank{side};
    end
    disp(['Number of trials above correlation threshold: ', num2str(sum(correlationBank{1, 2})), ' and ', ...
        num2str(sum(correlationBank{2, 2})), ' for the conjugate image,'])
    
    ElementBank{side, element} = ImgMeanTrial(:, :, 1);
    ElementBank{side, element} = ImgMeanTrial(:, :, 2);
end

In = cat(3, ElementBankTotal{1, [1, 2, 3, 4, 5, 6, 7, 9] });
Out = cat(3, ElementBankTotal{2, [1, 2, 3, 4, 5, 6, 7, 9] });
mIn = mean(In, 3);
mOut = mean(Out, 3);

figure, 
subplot(2, 2, 1)
imagesc(mIn)
title('Attention In')
set(gca, 'FontSize', 10)
axis off

subplot(2, 2, 3)
imagesc(mOut)
title('Attention Out')
set(gca, 'FontSize', 10)
axis off

unityL = min(min(mOut(:)), min(mIn(:)));
unityU = max(max(mOut(:)), max(mIn(:)));
unityLine = linspace(unityL, unityU, 1e2);

subplot(2, 2, [2 4])
hold all
scatter(mOut(:), mIn(:))
% plot(unityLine, unityLine, '--k')
axis equal
fitlm(mOut(:), mIn(:))
xlabel('Attend Out')
ylabel('Attend In')
set(gca, 'FontSize', 15)

%%
col = 120 : 250;
row = 50 : 250;
filterSize = 4;

clear EBankTotal_In_Time EBankTotal_Out_Time 
clear EBank_mIn_Time EBank_mOut_Time
EBankTotal_In_Time = [];
EBankTotal_Out_Time = [];

for time = 7 : 14
clear ElementBankTotal ImgMeanTrial M ImgMeanTrial
clear ElementBank In Out mIn mOut
for element = [1, 2, 3, 4, 5, 6, 7, 9] 
    % Image dataset selection
    Img{1} = imgDS_prob1_b4{element}; % select image
    Img{2} = imgDS_prob1_b4{element + 9}; % select conjugate image 
    correlationThreshold = .5;
    
    % NAN help
    Img{1}(isnan(Img{1})) = 0;
    Img{2}(isnan(Img{2})) = 0;
    
    clear correlationBank Im ImgBank  
    for side = [1 2]
        for trial = 1 : size(Img{side}, 4)
            Im{1} = imgaussfilt(Img{side}(row, col, time, 1), filterSize);
            Im{2}= imgaussfilt(Img{side}(row, col, time, trial), filterSize);
            M = fitlm(Im{2}(:), Im{1}(:));
            correlationBank{side, 1}(trial) = sqrt(M.Rsquared.Ordinary);
            disp(['Element: ', num2str(element), ' Trial: ', num2str(trial), ' and Time: ', num2str(time)])
        end
         correlationBank{side, 2} = correlationBank{side} > correlationThreshold;
         ImgBank{side} = squeeze(imgaussfilt(Img{side}(row, col, time, correlationBank{side, 2}), filterSize));
         ImgMeanTrial(:, :, side) = nanmean(ImgBank{side}, 3);
         ElementBankTotal{side, element} = ImgBank{side};
    end
    disp(['Number of trials above correlation threshold: ', num2str(sum(correlationBank{1, 2})), ' and ', ...
        num2str(sum(correlationBank{2, 2})), ' for the conjugate image.'])
    
    ElementBank{side, element} = ImgMeanTrial(:, :, 1);
    ElementBank{side, element} = ImgMeanTrial(:, :, 2);
end

In = cat(3, ElementBankTotal{1, [1, 2, 3, 4, 5, 6, 7, 9] });
Out = cat(3, ElementBankTotal{2, [1, 2, 3, 4, 5, 6, 7, 9] });
mIn = mean(In, 3);
mOut = mean(Out, 3);

EBank_mIn_Time(:, :, time - 6) = mIn;
EBank_mOut_Time(:, :, time - 6) = mOut;
end

figure
for time = 1 : 8
    subplot(4, 2, time)
    hold on
    In = EBank_mOut_Time(:, :, time);
    Out = EBank_mIn_Time(:, :, time);
    scatter(Out(:), In(:))
    % plot(unityLine, unityLine, '--k')
    axis equal
    fitlm(mOut(:), mIn(:))
    xlabel('Attend Out')
    ylabel('Attend In')
    set(gca, 'FontSize', 15)
    title(['Time: ', num2str(time + 6)])
end
