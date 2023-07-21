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
libraryOfFilledTrials = cell(9, 2);

%%
Img = imgDS_prob1_b4{ 1 };
trial = 1; time = 16; row = 50 : 250; col = 120 : 270;
Img_Fixed = Img(row, col, time, trial);
Img_Fixed(isnan(Img_Fixed)) = 0;
Img_Fixed = imgaussfilt(Img_Fixed, 4);

for element = 1 : size(libraryOfmissingTrials, 1)*size(libraryOfmissingTrials, 2)
    library_E = libraryOfmissingTrials{ element };
    clear Bank
    Bank = [0, 0, 0, 0, 0];

    Img = imgDS_prob1_b4{ element };
    time = 14;
    
    tic
    parfor trial = 1 : length(library_E)
        if ~isequal( isnan( Img(:, :, 14, library_E(trial))), ones(316, 316))
            for r = -49 : 30
                for c = -40 : 40
                    for rot = -15 : 15
                        F = Img(row + r, col + c, time, library_E(trial));
                        F(isnan(F)) = 0;
                        F = imrotate(F, rot, 'bilinear', 'crop');
                        F = imgaussfilt(F, 4);
                        M = fitlm(F(:), Img_Fixed(:));
                        x = sqrt(M.Rsquared.Ordinary);
                        Bank = [Bank; [library_E(trial) r c rot x]];
                    end
                    disp([num2str(element), ' ', num2str(library_E(trial)),' ',num2str(r),' ',num2str(c)])
                end
            end
        
        elseif ~isequal( isnan( Img(:, :, 13, library_E(trial))), ones(316, 316))
            for r = -49 : 30
                for c = -40 : 40
                    for rot = -15 : 15
                        F = Img(row + r, col + c, 13, library_E(trial));
                        F(isnan(F)) = 0;
                        F = imrotate(F, rot, 'bilinear', 'crop');
                        F = imgaussfilt(F, 4);
                        M = fitlm(F(:), Img_Fixed(:));
                        x = sqrt(M.Rsquared.Ordinary);
                        Bank = [Bank; [library_E(trial) r c rot x]];
                    end
                    disp([num2str(library_E(trial)),' ',num2str(r),' ',num2str(c)])
                end
            end
        end

    end
    toc
    libraryOfFilledTrials{ element } = Bank;
end

%%
b =Bank;
[V, L] = max(b(:, end));
Bank(L, :)

%%
clc
figure, 
subplot(3, 2, 2)
imagesc(Img_Fixed)
axis off
title('Fixed Image')

subplot(3, 2, 4)
F = Img(row + Bank(L, 2), col + Bank(L, 3), time, Bank(L, 1));
F(isnan(F)) = 0;
F = imrotate(F, Bank(L, 4), 'bilinear', 'crop');
F = imgaussfilt(F, 4);
M = fitlm(F(:), Img_Fixed(:));
imagesc(F)
axis off
title('Moved Image')

subplot(3, 2, 1)
imagesc(Img(:, :, time, 1))
axis off
title('Image Fixed')

subplot(3, 2, 3)
imagesc( Img(:, :, time, Bank(L, 1)) )
axis off
title('Moving Image')

subplot(3, 2, 5)
A = Img(:, :, time, Bank(L, 1));
B = Img(:, :, time, 1);
hold all
scatter(B(:), A(:))
ylabel('Moving Image')
xlabel('Fixing Image')
M = fitlm(B(:), A(:));
title(sqrt(M.Rsquared.Ordinary))
title(['R: ', num2str(sqrt(M.Rsquared.Ordinary))])
set(gca, 'FontSize', 15)

subplot(3, 2, 6)
hold all
scatter(Img_Fixed(:), F(:))
ylabel('Moved Image')
xlabel('Fixing Image')
M = fitlm(Img_Fixed(:), F(:));
title(['R: ', num2str(sqrt(M.Rsquared.Ordinary))])
set(gca, 'FontSize', 15)

sgtitle('Trial 27', 'FontSize', 15)

%%
% Bank_e18_type2_c = Bank;
% save('Bank_e18_type2_c.mat', 'Bank_e18_type2_c')

%%
Bank_e13_type2_c(find(Bank_e13_type2_c(:, 1) == 0), :) = [];

%%
Bank_e13_type2 = [Bank_e13_type2_a; Bank_e13_type2_b; Bank_e13_type2_c];

%% Big bank
