timWin = 2 : 20;
row = [50 : 250]; col = [120 : 280];

[Ret] = RetinoLoadB();
R = cat(4, Ret{:});
Rtim = squeeze(R(:, :, timWin, :));
Rtim(isnan(Rtim)) = 0;
Rtim = Rtim - mean(Rtim, 3);
Rvec = Rtim(row, col, :, :);
Rvec = reshape(Rvec, [201*161 19 777]);
Rvec = permute(Rvec, [1 3 2]);
Rvec = reshape(Rvec, [201*161*777 19]);

figure, plot( mean(Rvec, 1) );

%%
[U, ~, ~] = svd(Rvec', 'econ');

%%
figure
plot(U(:,1), 'LineWidth', 2)
hold on
plot(U(:,2), 'LineWidth', 2)
legend('PC 1', 'PC 2')
xlabel('Time (ms)')
ylabel('Amp')
set(gca, 'FontSize', 25)
xticks([2 : 2 : 18])
xticklabels({'100', '300', '500', '700', '900', '1100', '1300', '1500', '1700'})
