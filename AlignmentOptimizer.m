load('B.m', 'imgDS_prob1_b4')

%%
element = 1;
time = 16;
X = squeeze(imgDS_prob1_b4{1}(:, :, time, :));
X(isnan(X)) = 0;

%%
G_1 = sum(X(:, :, 1 : 19), 3);
G_1 = imrotate(G_1, 0, 'bilinear', 'crop');
G_1 = imtranslate(G_1, [0 0]);

G_2 = sum(X(:, :, 20 : 29), 3);
G_2 = imrotate(G_2, -3, 'bilinear', 'crop');
G_2 = imtranslate(G_2, [-13 0]);

G_3 = sum(X(:, :, 30 : 33), 3);
G_3 = imrotate(G_3, -3, 'bilinear', 'crop');
G_3 = imtranslate(G_3, [10 0]);

G_4 = sum(X(:, :, 34 : 46), 3);
G_4 = imrotate(G_4, -4, 'bilinear', 'crop');
G_4 = imtranslate(G_4, [10 -10]);

G_5 = sum(X(:, :, 48 : 54), 3);
G_5 = imrotate(G_5, -3, 'bilinear', 'crop');
G_5 = imtranslate(G_5, [20 0]);

G_6 = sum(X(:, :, 56 : 68), 3);
G_6 = imrotate(G_6, -3, 'bilinear', 'crop');
G_6 = imtranslate(G_6, [10 -10]);

%%
filt = 3;
figure, 
subplot(2, 3, 1)
imagesc(imgaussfilt(G_1, filt))
title('1')

subplot(2, 3, 2)
imagesc(imgaussfilt(G_2, filt))
title('2')

subplot(2, 3, 3)
imagesc(imgaussfilt(G_3, filt))
title('3')

subplot(2, 3, 4)
imagesc(imgaussfilt(G_4, filt))
title('4')

subplot(2, 3, 5)
imagesc(imgaussfilt(G_5, filt))
title('5')

subplot(2, 3, 6)
imagesc(imgaussfilt(G_6, filt))
title('6')

%%
Gtot = 1*G_1 + 1*G_2 + 1*G_3 + 1*G_4 + 1*G_5 + 1*G_6;
figure,
subplot(2, 2, 1)
imagesc(Gtot)

subplot(2, 2, 3)
imagesc(sum(X, 3))

subplot(2, 2, 2)
imagesc( imgaussfilt(Gtot, 3) )

subplot(2, 2, 4)
imagesc( imgaussfilt(sum(X, 3), 3) )

%% Calculating Correlations step 1
Bank = cell(2, 6);
Bank{2, 1} = sum(X(:, :, 1 : 19), 3);
Bank{2, 2} = sum(X(:, :, 20 : 29), 3);
Bank{2, 3} = sum(X(:, :, 30 : 33), 3);
Bank{2, 4} = sum(X(:, :, 34 : 46), 3);
Bank{2, 5} = sum(X(:, :, 48 : 54), 3);
Bank{2, 6} = sum(X(:, :, 56 : 68), 3);

%% Calculating Correlations step 1
G_1 = sum(X(:, :, 1 : 19), 3);
G_1 = imrotate(G_1, 0, 'bilinear', 'crop');
Bank{1, 1} = imtranslate(G_1, [15 0]);

G_2 = sum(X(:, :, 20 : 29), 3);
G_2 = imrotate(G_2, -3, 'bilinear', 'crop');
Bank{1, 2} = imtranslate(G_2, [-13 0]);

G_3 = sum(X(:, :, 30 : 33), 3);
G_3 = imrotate(G_3, -3, 'bilinear', 'crop');
Bank{1, 3} = imtranslate(G_3, [10 0]);

G_4 = sum(X(:, :, 34 : 46), 3);
G_4 = imrotate(G_4, -4, 'bilinear', 'crop');
Bank{1, 4} = imtranslate(G_4, [10 -10]);

G_5 = sum(X(:, :, 48 : 54), 3);
G_5 = imrotate(G_5, -3, 'bilinear', 'crop');
Bank{1, 5} = imtranslate(G_5, [20 0]);

G_6 = sum(X(:, :, 56 : 68), 3);
G_6 = imrotate(G_6, -3, 'bilinear', 'crop');
Bank{1, 6} = imtranslate(G_6, [10 -10]);

clear Z_corr Z_pre
k = 1;
for z = 1 : 6
    for j = 1 : 6
        if z ~= j
            Z_corr( k ) = corr2( imgaussfilt(Bank{1, z}, 3), imgaussfilt(Bank{1, j}, 3) );
            Z_pre( k ) = corr2(imgaussfilt(Bank{2, z}, 3), imgaussfilt(Bank{2, j}, 3) );
            k = k + 1;
            k
        end
    end
end

mean(Z_corr)
mean(Z_pre)

%%
yy = 1; 
clear Z;
for y = -50 : 50
        G_1 = sum(X(:, :, 1 : 19), 3);
        G_1 = imrotate(G_1, 0, 'bilinear', 'crop');
        Bank{1, 1} = imtranslate(G_1, [y 0]);
        
        G_2 = sum(X(:, :, 20 : 29), 3);
        G_2 = imrotate(G_2, -3, 'bilinear', 'crop');
        Bank{1, 2} = imtranslate(G_2, [-13 0]);
        
        G_3 = sum(X(:, :, 30 : 33), 3);
        G_3 = imrotate(G_3, -3, 'bilinear', 'crop');
        Bank{1, 3} = imtranslate(G_3, [10 0]);
        
        G_4 = sum(X(:, :, 34 : 46), 3);
        G_4 = imrotate(G_4, -4, 'bilinear', 'crop');
        Bank{1, 4} = imtranslate(G_4, [10 -10]);
        
        G_5 = sum(X(:, :, 48 : 54), 3);
        G_5 = imrotate(G_5, -3, 'bilinear', 'crop');
        Bank{1, 5} = imtranslate(G_5, [20 0]);
        
        G_6 = sum(X(:, :, 56 : 68), 3);
        G_6 = imrotate(G_6, -3, 'bilinear', 'crop');
        Bank{1, 6} = imtranslate(G_6, [10 -10]);
        
        clear Z_corr Z_pre
        k = 1;
        for z = 1 : 6
            for j = 1 : 6
                if z ~= j
                    Z_corr( k ) = corr2( imgaussfilt(Bank{1, z}, 3), imgaussfilt(Bank{1, j}, 3) );
                    k = k + 1;
                end
            end
        end

        Z(yy) = mean(Z_corr);
        yy = yy + 1
end

%%
clc
figure, 
plot(-log(Z))
xlabel('\Delta Parameter')
ylabel('-log(Corr)')
set(gca, 'FontSize', 20)

%%
yy = 1; 
clear Z;
for y = -50 : 50
    yy1 = 1;
    for y1 = -50 : 50
        G_1 = sum(X(:, :, 1 : 19), 3);
        G_1 = imrotate(G_1, 0, 'bilinear', 'crop');
        Bank{1, 1} = imtranslate(G_1, [y y1]);
        
        G_2 = sum(X(:, :, 20 : 29), 3);
        G_2 = imrotate(G_2, -3, 'bilinear', 'crop');
        Bank{1, 2} = imtranslate(G_2, [-13 0]);
        
        G_3 = sum(X(:, :, 30 : 33), 3);
        G_3 = imrotate(G_3, -3, 'bilinear', 'crop');
        Bank{1, 3} = imtranslate(G_3, [10 0]);
        
        G_4 = sum(X(:, :, 34 : 46), 3);
        G_4 = imrotate(G_4, -4, 'bilinear', 'crop');
        Bank{1, 4} = imtranslate(G_4, [10 -10]);
        
        G_5 = sum(X(:, :, 48 : 54), 3);
        G_5 = imrotate(G_5, -3, 'bilinear', 'crop');
        Bank{1, 5} = imtranslate(G_5, [20 0]);
        
        G_6 = sum(X(:, :, 56 : 68), 3);
        G_6 = imrotate(G_6, -3, 'bilinear', 'crop');
        Bank{1, 6} = imtranslate(G_6, [10 -10]);
        
        clear Z_corr Z_pre
        k = 1;
        for z = 1 : 6
            for j = 1 : 6
                if z ~= j
                    Z_corr( k ) = corr2( imgaussfilt(Bank{1, z}, 3), imgaussfilt(Bank{1, j}, 3) );
                    Z_pre( k ) = corr2(imgaussfilt(Bank{2, z}, 3), imgaussfilt(Bank{2, j}, 3) );
                    k = k + 1;
                end
            end
        end

        Z(yy, yy1) = mean(Z_corr);
        yy1 = yy1 + 1;
        % mean(Z_pre)
    end
        yy = yy + 1
end

%%
clc
figure, 
mesh(-log(Z))
xlabel('\Delta Vertical')
ylabel('\Delta Horizontal')
zlabel('-log(Corr)')
set(gca, 'FontSize', 20)
xticks([0 : 10 : 100])
yticks([0 : 10 : 100])

%%
icon = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
func5 = @(x) fminAL3sub(X, x);
func5(icon)
options = optimset('Display', 'iter', 'PlotFcns', @optimplotfval);
options2 = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'sqp');
[y, val, exitflag, output] = fminsearch(func5, icon, options);
% [x] = fmincon(func3, [-50], [], [], [], [], [-50], [50], [], options2);

%%
G_1 = sum(X(:, :, 1 : 19), 3);
G_1 = imrotate(G_1, y(13), 'bilinear', 'crop');
G_1 = imtranslate(G_1, [y(1) y(2)]);

G_2 = sum(X(:, :, 20 : 29), 3);
G_2 = imrotate(G_2, y(14), 'bilinear', 'crop');
G_2 = imtranslate(G_2, [y(3) y(4)]);

G_3 = sum(X(:, :, 30 : 33), 3);
G_3 = imrotate(G_3, y(15), 'bilinear', 'crop');
G_3 = imtranslate(G_3,[y(5) y(6)]);

G_4 = sum(X(:, :, 34 : 46), 3);
G_4 = imrotate(G_4, y(16), 'bilinear', 'crop');
G_4 = imtranslate(G_4,[y(7) y(8)]);

G_5 = sum(X(:, :, 48 : 54), 3);
G_5 = imrotate(G_5, y(17), 'bilinear', 'crop');
G_5 = imtranslate(G_5, [y(9) y(10)]);

G_6 = sum(X(:, :, 56 : 68), 3);
G_6 = imrotate(G_6, y(18), 'bilinear', 'crop');
G_6 = imtranslate(G_6, [y(11) y(12)]);

filt = 3;
figure, 
subplot(2, 3, 1)
imagesc(imgaussfilt(G_1, filt))
title('1')

subplot(2, 3, 2)
imagesc(imgaussfilt(G_2, filt))
title('2')

subplot(2, 3, 3)
imagesc(imgaussfilt(G_3, filt))
title('3')

subplot(2, 3, 4)
imagesc(imgaussfilt(G_4, filt))
title('4')

subplot(2, 3, 5)
imagesc(imgaussfilt(G_5, filt))
title('5')

subplot(2, 3, 6)
imagesc(imgaussfilt(G_6, filt))
title('6')

Gtot = 1*G_1 + 1*G_2 + 1*G_3 + 1*G_4 + 1*G_5 + 1*G_6;
figure,
subplot(2, 1, 1)
imagesc(Gtot)

subplot(2, 1, 2)
imagesc(sum(X, 3))
