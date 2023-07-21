Bank_tot = cell(9, 2);
libraryOfImages = cell(9, 2);

%%
Bank_tot{18} = Bank_e18_type2;

%%
for e = 1 : 18
    Bank_tot{e}(find(Bank_tot{e}(:, 1) == 0), :) = [];
    e
end
Bank_tot2 = Bank_tot;

%%
save('Bank_tot.mat', 'Bank_tot', '-v7.3')

%%
transformationBank = [];
elements = unique(Bank_tot{e}(:, 1)); 
k = 1;
for n = 1 : length(elements)
    elementBank = Bank_tot{e}(Bank_tot{e}(:, 1) == elements(n), :);
    [val, loc] = max(elementBank(:, end));
    transformationBank(k, :) = elementBank(loc, :);
    k = k + 1; clear elementBank; k
end

%%
transformationBankGrand = [];
row = 50 : 250; col = 120 : 270;
for e = 1 : 18
    transformedImages = []; transformationBank = [];
    elements = unique(Bank_tot{e}(:, 1)); 
    k = 1;

    for n = 1 : length(elements)
        elementBank = Bank_tot{e}(Bank_tot{e}(:, 1) == elements(n), :);
        [val, loc] = max(elementBank(:, end));
        transformationBank(k, :) = elementBank(loc, :);
        k = k + 1; clear elementBank; 
    end
    
    Img = imgDS_prob1_b4{e};
    for n = 1 : length(transformationBank)
        for time = 1 : 45
            F = Img(row + transformationBank(n, 2), col + transformationBank(n, 3), time, transformationBank(n, 1));
            F(isnan(F)) = 0;
            F = imrotate(F, transformationBank(n, 4), 'bilinear', 'crop');
            transformedImages(:, :, time, n) = F;
        end
        disp(['element ', num2str(e), ' trial: ', num2str(n)])
    end
libraryOfImages{e} = transformedImages;
transformationBankGrand = [transformationBankGrand; transformationBank];
end

%%
figure,
for e = 1 : 18
    subplot(3, 6, e)
    M = mean(libraryOfImages{e}, 4);
    I = M(:, :, 16);
    imagesc(I)
end

%%
in = cell(9, 1); out = in;
for j = 1 : 9
    in{j} = libraryOfImages{j};
    out{j} = libraryOfImages{j + 9};
end
OUT = cat(4, in);

%%
IN = libraryOfImages{1};
for k = 2 : 9
    IN = cat(4, IN, libraryOfImages{k});
end
Min = nanmean(IN, 4);
Iin = Min(:, :, 20);
figure, 
imagesc(Iin)

OUT = libraryOfImages{10};
for k = 11 : 18
    OUT = cat(4, OUT, libraryOfImages{k});
end
Mout = nanmean(OUT, 4);
Iout = Mout(:, :, 20);
figure, 
imagesc(Iout)

%%
% for j = 1 : 9
%     M = libraryOfImages{j};
%     M = mean(M, 4);
%     M2 = M(:, :, 16);
% end

%%
figure, 
subplot(3, 1, 1)
imagesc(Iin)
title('Attend In')
set(gca, 'FontSize', 15)
axis off

subplot(3, 1, 2)
imagesc(Iout)
title('Attend Out')
set(gca, 'FontSize', 15)
axis off

subplot(3, 1, 3)
scatter(Iout(:), Iin(:))
xlabel('Attend Out')
ylabel('Attend In')
set(gca, 'FontSize', 15)

%%
imagesc(Iin .* Iout)

%%
clc
figure,
k = 1;
for time = 4 : 21
subplot(3, 6, k)
Iout = Mout(:, :, time) - mean(Mout(:, :, :), 3);
Iin = Min(:, :, time) - mean(Min(:, :, :), 3);
scatter(Iout(:), Iin(:))
mm = fitlm(Iout(:), Iin(:));
k = k + 1;
axis square
title(['Time frame: ', num2str(time), ' Slope: ', num2str(mm.Coefficients.Estimate(2))])
xlabel('Attend Out')
ylabel('Attend In')
set(gca, 'FontSize', 15)
legend(['R: ', num2str(sqrt(mm.Rsquared.Ordinary))])
end

%%
tMout = reshape(Mout, [size(Mout, 1)*size(Mout, 2) size(Mout, 3)]);
tMin = reshape(Min, [size(Min, 1)*size(Min, 2) size(Min, 3)]);

figure, 
subplot(2, 1, 1)
for pix = 1 : size(tMin, 1)
    hold all
    plot(tMin(pix, :))
    pix
end
xlabel( 'Time (ms)' )
ylabel('F%')
set(gca, 'FontSize', 25)
title('Attend In')

subplot(2, 1, 2)
for pix = 1 : size(tMout, 1)
    hold all
    plot(tMout(pix, :))
    pix
end
xlabel( 'Time (ms)' )
ylabel('F%')
set(gca, 'FontSize', 25)
title('Attend Out')

%%
tMin = tMin -  mean(tMin, 2);
tMout = tMout -  mean(tMout, 2);

figure, 
plot(mean(tMin, 1), 'LineWidth', 2)
hold on
plot(mean(tMout, 1), 'LineWidth', 2)
xlabel( 'Time (ms)' )
ylabel('F%')
set(gca, 'FontSize', 25)

x = 5 : 14;
x2 = 14 : -1 : 5;
y = mean(tMin, 1);
y2 = mean(tMout, 1);
patch( [x, x2], [y(5 : 14), y2(14:-1:5)], 'g' )
alpha(.3)
legend('Attend In', 'Attend Out', 'Attentional Modulation')

%%
figure, 
subplot(2, 2, 1)
histogram(transformationBankGrand(:, 2))
xlabel('Vertical Translation')
set(gca, 'FontSize', 15)

subplot(2, 2, 2)
histogram(transformationBankGrand(:, 3))
xlabel('Horizontal Translation')
set(gca, 'FontSize', 15)

subplot(2, 2, 3)
histogram(transformationBankGrand(:, 4))
xlabel('Rotational Translation')
set(gca, 'FontSize', 15)

subplot(2, 2, 4)
histogram(transformationBankGrand(:, 5))
xlabel('Correlation')
set(gca, 'FontSize', 15)
