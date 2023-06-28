P = imgDS_prob1_b4{1};

%%
time = 14;
figure, 
subplot(2, 1, 1)
imagesc(P(:, :, time, 1))

subplot(2, 1, 2)
imagesc(P(:, :, time, 25))

%% Heat map creation
M = P(:, :, time, 1);
M_1 = P(:, :, time, 25);

M(~isnan(M)) = 1;
M(isnan(M)) = 0;

M_1(~isnan(M_1)) = 1;
M_1(isnan(M_1)) = 0;

figure, 
subplot(2, 1, 1)
imagesc(M)

subplot(2, 1, 2)
imagesc(M_1)

%% M_1 * X = M => X = (M_1)^-1 * M
M_1inv = pinv(M_1);
X = M_1inv*M;

%%
Mp = M_1*X;

%%
figure, 
subplot(2, 1, 1)
imagesc(M_1)

subplot(2, 1, 2)
imagesc(Mp)

%%
P_1 = P(:, :, time, 25);
P_1(isnan(P_1)) = 0;
MP_1 = P_1*X;

%%
figure, 
histogram(MP_1)
hold on
histogram(P_1)

%%
figure, 
subplot(2, 1, 1)
imagesc(MP_1)

subplot(2, 1, 2)
imagesc(P_1)

%%
M = P(:, :, time, 1);
M_1 = P(:, :, time, 25);

M(~isnan(M)) = 1;
M(isnan(M)) = 0;

M_1(~isnan(M_1)) = 1;
M_1(isnan(M_1)) = 0;

M_1inv = pinv(M_1);
X = M_1inv*M;
