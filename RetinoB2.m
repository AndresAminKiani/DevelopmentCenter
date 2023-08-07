cd /home/range1-raid2/sgwarren-data/Deviant/Blofeld/Data/Deviant/B
datadir = '/home/range1-raid2/sgwarren-data/Deviant/Blofeld/Data/Deviant/B';
posidata = load('PositionTuning_AlignTo_stimulusOnTime.mat'); 
cd ~/matlab/OpticalImagingProject

timeWindow = 5:20; 
stimOnset = 11;

posiTuningImg = ImageHelper.convertSparseToFull(posidata.S,posidata.IX, posidata.V);

imgMask = []; % image Mask, [xrange; yrange];
nTrials = size(posiTuningImg, 4); % total number of trials
allStimIndex = zeros(1,nTrials);
for i=1:nTrials
    allStimIndex(i) = posidata.T(i).trialDescription.deviantPosition;
end

img = cell(1,18); % we total have 18 conditions, 0~17
for i=1:18 % 18 positions
    img{i} = posiTuningImg(:, :, :, allStimIndex==(i-1));
end

posiTuningImg = img(1:9);
posiTuningImg = cellfun(@(x) permute(x,[1 2 4 3]), posiTuningImg, 'UniformOutput',0); % height X width X trial X time;
posiTuningImgCopy = posiTuningImg;

posiTuningImg = cellfun(@(x) squeeze(nanmean(x, 3)), posiTuningImgCopy, 'UniformOutput',0); % average trials
posiTuningImg = cellfun(@(x) x(:, :, timeWindow), posiTuningImg, 'UniformOutput',0); % extract time window;

if ~isempty(imgMask)
    for i=1:9, posiTuningImg{i}(imgMask(1,1):imgMask(1,2), imgMask(2,1):imgMask(2,2), :)=nan; end %
end

posiTuningImg = cellfun(@(x) reshape(x,[316*316 length(timeWindow)]), posiTuningImg, 'UniformOutput',0); 
nanMask = cellfun(@(x) ~any(isnan(x),2), posiTuningImg, 'UniformOutput',0); % create a nan value mask, necessary to use it later
posiTuningImg = cellfun(@(x,y) x(y,:)', posiTuningImg, nanMask, 'UniformOutput',0); % time X pixel*pixel in each cell

posiTuningImg = cellfun(@(x) x-repmat(mean(x,2),1,size(x,2)), posiTuningImg, 'UniformOutput',0);
grandImg = cat(2,posiTuningImg{:});

load('U.mat')
compoGrand = -U(:,1);

valueLoad = cellfun(@(x) compoGrand'*x, posiTuningImg, 'UniformOutput',0);

valueImg = repmat({NaN(1,316*316)},[1,9]);
valueImg = cellfun(@(x) reshape(x, [316 316]), valueImg, 'UniformOutput',0);
for i=1:9; valueImg{i}(nanMask{i})=valueLoad{i}; end

valueImg_mat = cat(3, valueImg{[9 3 6 8 2 5 7 1 4]}); % concatenate images
valueImg_mat_demean = valueImg_mat-repmat(nanmean(valueImg_mat,3),[1 1 9]);

ran = [20 170 80 200];

clear B;
hold all
for j = 1:9
    subplot(3,3,j)
    hh = valueImg_mat_demean2(:,:,1);
    hh = reshape(hh,[],1);
    imagesc(valueImg_mat_demean2(ran(1):ran(2),ran(3):ran(4),j), [(nanmean(hh) - .5*nanstd(hh)) (nanmean(hh) + .5*nanstd(hh))]);
    B(:,:,j) = valueImg_mat_demean2(ran(1):ran(2),ran(3):ran(4),j);
    title(sprintf('Element: %i',j))
    colorbar
    caxis([-.3 .3])
    axis equal
end

clc
clear B;
for j = 1:9
 B(:,:,j) = valueImg_mat_demean2(ran(1):ran(2),ran(3):ran(4),j);
end
h=figure;
set(h,'Position',[0 0 800 600]);
hold all
h3 = fspecial('disk',10);
for j = 1:9
    subplot(3,3,j)
    hh = B(:,:,j);
    hh = reshape(hh,[],1);
    hh2 = hh;
    hh2(hh2 < nanmean(hh2) - 1*nanstd(hh2)) = 0;
    hh2(hh2 < nanmean(hh2) + 1*nanstd(hh2)) = 0;
    hh2 = reshape(hh2,[size(B, 1),size(B, 2)]);
    imagesc(imgaussfilt(hh2, 2),...
        [(nanmean(hh) - 1*nanstd(hh)) (nanmean(hh) + 2*nanstd(hh))]);
    title(sprintf('Element: %i',j))
end
