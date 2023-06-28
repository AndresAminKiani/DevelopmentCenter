time = 12;
trial = 1;

Img = imgDS_prob1_b4{1};
shiftBank = zeros(size(Img, 4), 4); % trial x 4 sides

HeatMap = Img(:, :, time, trial);
HeatMap(~isnan(HeatMap)) = 1;
HeatMap(isnan(HeatMap)) = 0;

%  if nansum(nansum(HeatMap)) % if empty move on

%%
k = 0;
while sum(colVector_L)  == 0
%     colVector_R = HeatMap(:, end);
    colVector_L = HeatMap(:, 1 + k);
    
%     rowVector_H = HeatMap(1, :);
%     rowVector_L = HeatMap(end, :);
k = k + 1;
k
end

k = 0;
while sum(colVector_R)  == 0
    colVector_R = HeatMap(:, end - k);
%     colVector_L = HeatMap(:, 1 + k);
    
%     rowVector_H = HeatMap(1, :);
%     rowVector_L = HeatMap(end, :);
k = k + 1;
k
end

k = 0;
while sum(rowVector_H)  == 0
%     colVector_R = HeatMap(:, end - k);
%     colVector_L = HeatMap(:, 1 + k);
    
    rowVector_H = HeatMap(1 + k, :);
%     rowVector_L = HeatMap(end, :);
k = k + 1;
k
end

k = 0;
while sum(rowVector_L) == 0
%     colVector_R = HeatMap(:, end - k);
%     colVector_L = HeatMap(:, 1 + k);
    
%     rowVector_H = HeatMap(1 + k, :);
    rowVector_L = HeatMap(end - k, :);
k = k + 1;
k
end

%%
clc
cV_L = 0; cV_R = 0; rV_H = 0; rV_L = 0;
k = 0;
colVector_L = zeros(size(HeatMap, 1), 1); colVector_R = zeros(size(HeatMap, 1), 1);
rowVector_H = zeros(size(HeatMap, 2), 1); rowVector_L = zeros(size(HeatMap, 2), 1);

while (sum(colVector_L)  == 0) || sum(colVector_R)  == 0 ||...
        sum(rowVector_H)  == 0 || sum(rowVector_L) == 0
    if sum(colVector_L) == 0
        colVector_L = HeatMap(:, 1 + cV_L);
        cV_L = cV_L + 1;
    end
        
    if sum(colVector_R) == 0
        colVector_R = HeatMap(:, end - cV_R);
        cV_R = cV_R + 1;
    end

    if sum(rowVector_H) == 0
        rowVector_H = HeatMap(1 + rV_H, :);
        rV_H = rV_H + 1;
    end

    if sum(rowVector_L) == 0
        rowVector_L = HeatMap(end - rV_L, :);
        rV_L = rV_L + 1;
    end
    disp([num2str(cV_L),' ',num2str(cV_R),' ',num2str(rV_L),' ',num2str(rV_H)])
end

%%
HeatMap2 = HeatMap;
figure, 
HeatMap2(rV_H, 316 - cV_R + 1) = 2;
HeatMap2(316 - rV_L + 1, cV_L) = 2;
imagesc(HeatMap2)

%%
HeatMap2 = HeatMap;
figure, 
HeatMap2(rV_H, 316 - cV_R + 1) = 2;
HeatMap2(316 - rV_L + 1, cV_L) = 2;
imagesc(HeatMap2)
