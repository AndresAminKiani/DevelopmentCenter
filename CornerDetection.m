time = 12;
trial = 26;

Img = imgDS_prob1_b4{2};
shiftBank = zeros(size(Img, 4), 4); % trial x 4 sides

HeatMap = Img(:, :, time, trial);
HeatMap(~isnan(HeatMap)) = 1;
HeatMap(isnan(HeatMap)) = 0;

%  if nansum(nansum(HeatMap)) % if empty move on
clc
cL = 0; cR = 0; rH = 0; rL = 0;
k = 0;
colVector_L = zeros(size(HeatMap, 1), 1); colVector_R = zeros(size(HeatMap, 1), 1);
rowVector_H = zeros(size(HeatMap, 2), 1); rowVector_L = zeros(size(HeatMap, 2), 1);

while (sum(colVector_L)  == 0) || sum(colVector_R)  == 0 ||...
        sum(rowVector_H)  == 0 || sum(rowVector_L) == 0
    if sum(colVector_L) == 0
        colVector_L = HeatMap(:, 1 + cL);
        cL = cL + 1;
    else
        cLr_mx = max(find(colVector_L));
        cLr_mn = min(find(colVector_L));
    end
        
    if sum(colVector_R) == 0
        colVector_R = HeatMap(:, end - cR);
        cR = cR + 1;
    else
        cRr_mx = max(find(colVector_R));
        cRr_mn = min(find(colVector_R));
    end

    if sum(rowVector_H) == 0
        rowVector_H = HeatMap(1 + rH, :);
        rH = rH + 1;
    else
        rHc_mx = max(find(rowVector_H));
        rHc_mn = min(find(rowVector_H));        
    end

    if sum(rowVector_L) == 0
        rowVector_L = HeatMap(end - rL, :);
        rL = rL + 1;
    else
        rLc_mx = max(find(rowVector_L));
        rLc_mn = min(find(rowVector_L));     
    end
    disp([num2str(cL),' ',num2str(cR),' ',num2str(rL),' ',num2str(rH)])
end
rL = 316 - rL + 1;
cR = 316 - cR + 1;
x = [rL rH rL rH];
y = [abs( [rL] - [cLr_mn]),...
    abs( [rH] - [cLr_mn]),...
    abs( [rL] - [cLr_mx]),...
    abs( [rH] - [cLr_mx])];
[~, L] = min(y);
cLr = x(L);
x = [rL rH rL rH];
y = [abs( [rL] - [cRr_mn]),...
    abs( [rH] - [cRr_mn]),...
    abs( [rL] - [cRr_mx]),...
    abs( [rH] - [cRr_mx])];
[~, L] = min(y);
cRr = x(L);
%
HeatMap2 = HeatMap;
figure, 
HeatMap2(cRr, cR) = 2;
HeatMap2(cLr, cL) = 2;
imagesc(HeatMap2)

%%
time = 12;
figure,
for trial = 1 : 60
Img = imgDS_prob1_b4{2};
shiftBank = zeros(size(Img, 4), 4); % trial x 4 sides

HeatMap = Img(:, :, time, trial);
HeatMap(~isnan(HeatMap)) = 1;
HeatMap(isnan(HeatMap)) = 0;

if nansum(nansum(HeatMap)) % if empty move on
clc
cL = 0; cR = 0; rH = 0; rL = 0;
k = 0;
colVector_L = zeros(size(HeatMap, 1), 1); colVector_R = zeros(size(HeatMap, 1), 1);
rowVector_H = zeros(size(HeatMap, 2), 1); rowVector_L = zeros(size(HeatMap, 2), 1);

while (sum(colVector_L)  == 0) || sum(colVector_R)  == 0 ||...
        sum(rowVector_H)  == 0 || sum(rowVector_L) == 0
    if sum(colVector_L) == 0
        colVector_L = HeatMap(:, 1 + cL);
        cL = cL + 1;
    else
        cLr_mx = max(find(colVector_L));
        cLr_mn = min(find(colVector_L));
    end
        
    if sum(colVector_R) == 0
        colVector_R = HeatMap(:, end - cR);
        cR = cR + 1;
    else
        cRr_mx = max(find(colVector_R));
        cRr_mn = min(find(colVector_R));
    end

    if sum(rowVector_H) == 0
        rowVector_H = HeatMap(1 + rH, :);
        rH = rH + 1;
    else
        rHc_mx = max(find(rowVector_H));
        rHc_mn = min(find(rowVector_H));        
    end

    if sum(rowVector_L) == 0
        rowVector_L = HeatMap(end - rL, :);
        rL = rL + 1;
    else
        rLc_mx = max(find(rowVector_L));
        rLc_mn = min(find(rowVector_L));     
    end
    disp([num2str(cL),' ',num2str(cR),' ',num2str(rL),' ',num2str(rH)])
end
rL = 316 - rL + 1;
cR = 316 - cR + 1;
x = [rL rH rL rH];
y = [abs( [rL] - [cLr_mn]),...
    abs( [rH] - [cLr_mn]),...
    abs( [rL] - [cLr_mx]),...
    abs( [rH] - [cLr_mx])];
[~, L] = min(y);
cLr = x(L);
x = [rL rH rL rH];
y = [abs( [rL] - [cRr_mn]),...
    abs( [rH] - [cRr_mn]),...
    abs( [rL] - [cRr_mx]),...
    abs( [rH] - [cRr_mx])];
[~, L] = min(y);
cRr = x(L);

if cLr > 158
cLr = cLr -  min(abs(cLr - find(HeatMap(:, cL))));
else  
cLr = cLr +  min(abs(cLr - find(HeatMap(:, cL))));
end

if cRr > 158
    cRr = cRr - min(abs(cRr - find(HeatMap(:, cR))));
else 
    cRr = cRr + min(abs(cRr - find(HeatMap(:, cR))));
end
cLr( cLr < 0) = 1;

HeatMap2 = HeatMap;
HeatMap2(cRr, cR) = 2;
HeatMap2(cLr, cL) = 2;
HeatMap2(X(L, 1), X(L, 2)) = 2;
imagesc(HeatMap2) 
end
title(num2str(trial))
w = waitforbuttonpress
end

%%

time = 12;
figure,
for trial = 1 : 60
Img = imgDS_prob1_b4{2};
shiftBank = zeros(size(Img, 4), 4); % trial x 4 sides

HeatMap = Img(:, :, time, trial);
HeatMap(~isnan(HeatMap)) = 1;
HeatMap(isnan(HeatMap)) = 0;

if nansum(nansum(HeatMap)) % if empty move on
clc
cL = 0; cR = 0; rH = 0; rL = 0;
k = 0;
colVector_L = zeros(size(HeatMap, 1), 1); colVector_R = zeros(size(HeatMap, 1), 1);
rowVector_H = zeros(size(HeatMap, 2), 1); rowVector_L = zeros(size(HeatMap, 2), 1);

while (sum(colVector_L)  == 0) || sum(colVector_R)  == 0 ||...
        sum(rowVector_H)  == 0 || sum(rowVector_L) == 0
    if sum(colVector_L) == 0
        colVector_L = HeatMap(:, 1 + cL);
        cL = cL + 1;
    else
        cLr_mx = max(find(colVector_L));
        cLr_mn = min(find(colVector_L));
    end
        
    if sum(colVector_R) == 0
        colVector_R = HeatMap(:, end - cR);
        cR = cR + 1;
    else
        cRr_mx = max(find(colVector_R));
        cRr_mn = min(find(colVector_R));
    end

    if sum(rowVector_H) == 0
        rowVector_H = HeatMap(1 + rH, :);
        rH = rH + 1;
    else
        rHc_mx = max(find(rowVector_H));
        rHc_mn = min(find(rowVector_H));        
    end

    if sum(rowVector_L) == 0
        rowVector_L = HeatMap(end - rL, :);
        rL = rL + 1;
    else
        rLc_mx = max(find(rowVector_L));
        rLc_mn = min(find(rowVector_L));     
    end
    disp([num2str(cL),' ',num2str(cR),' ',num2str(rL),' ',num2str(rH)])
end
rL = 316 - rL + 1;
cR = 316 - cR + 1;
x = [rL rH rL rH];
y = [abs( [rL] - [cLr_mn]),...
    abs( [rH] - [cLr_mn]),...
    abs( [rL] - [cLr_mx]),...
    abs( [rH] - [cLr_mx])];
[~, L] = min(y);
cLr = x(L);
x = [rL rH rL rH];
y = [abs( [rL] - [cRr_mn]),...
    abs( [rH] - [cRr_mn]),...
    abs( [rL] - [cRr_mx]),...
    abs( [rH] - [cRr_mx])];
[~, L] = min(y);
cRr = x(L);

if cLr > 158
cLr = cLr -  min(abs(cLr - find(HeatMap(:, cL))));
else  
cLr = cLr +  min(abs(cLr - find(HeatMap(:, cL))));
end

if cRr > 158
    cRr = cRr - min(abs(cRr - find(HeatMap(:, cR))));
else 
    cRr = cRr + min(abs(cRr - find(HeatMap(:, cR))));
end
cLr( cLr < 0) = 1;

HeatMap2 = HeatMap;
x = ceil([cR + cL]/2);
y = ceil([cRr + cLr]/2);
k = 1;
for j = 1: 316 - (cL + x)
    for z = 1 : 316 - (cRr + y)
        a = HeatMap2(cL + x + j, cRr + y + z);
        if a == 1
            X(k, :) = [cL + x + j, cRr + y + z];
            k = k + 1;
            k
        end
    end
end

sX = sum(X, 2);
[V, L] = max(sX);
X(L, :)

HeatMap2(cRr, cR) = 2;
HeatMap2(cLr, cL) = 2;
HeatMap2(X(L, 1), X(L, 2)) = 2;
imagesc(HeatMap2) 
end
title(num2str(trial))
w = waitforbuttonpress
clear X
end
