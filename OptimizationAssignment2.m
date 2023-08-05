Bank = cell(1, 6);
Bank{2, 1} = sum(X(:, :, 1 : 19), 3);
Bank{2, 2} = sum(X(:, :, 20 : 29), 3);
Bank{2, 3} = sum(X(:, :, 30 : 33), 3);
Bank{2, 4} = sum(X(:, :, 34 : 46), 3);
Bank{2, 5} = sum(X(:, :, 48 : 54), 3);
Bank{2, 6} = sum(X(:, :, 56 : 68), 3);

yy = 1; 
clear Z;
for y = -50 : 50
        A_1 = sum(X(:, :, 1 : 19), 3);
        A_1 = imrotate(A_1, 0, 'bilinear', 'crop');
        A_1 = imtranslate(A_1, [y 0]);
        Bank{1, 1} = A_1;
        
        A_2 = sum(X(:, :, 20 : 29), 3);
        A_2 = imrotate(A_2, -3, 'bilinear', 'crop');
        A_2 = imtranslate(A_2, [-13 0]);
        Bank{1, 2} = A_2;
        
        A_3 = sum(X(:, :, 30 : 33), 3);
        A_3 = imrotate(A_3, -3, 'bilinear', 'crop');
        A_3 = imtranslate(A_3, [10 0]);
        Bank{1, 3} = A_3;
        
        A_4 = sum(X(:, :, 34 : 46), 3);
        A_4 = imrotate(A_4, -4, 'bilinear', 'crop');
        A_4 = imtranslate(A_4, [10 -10]);
        Bank{1, 4} = A_4;
        
        A_5 = sum(X(:, :, 48 : 54), 3);
        A_5 = imrotate(A_5, -3, 'bilinear', 'crop');
        A_5 = imtranslate(A_5, [20 0]);
        Bank{1, 5} = A_5;
        
        A_6 = sum(X(:, :, 56 : 68), 3);
        A_6 = imrotate(A_6, -3, 'bilinear', 'crop');
        A_6 = imtranslate(A_6, [10 -10]);
        Bank{1, 6} = A_6;
        
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
Bank = cell(1, 6);
Bank{2, 1} = sum(X(:, :, 1 : 19), 3);
Bank{2, 2} = sum(X(:, :, 20 : 29), 3);
Bank{2, 3} = sum(X(:, :, 30 : 33), 3);
Bank{2, 4} = sum(X(:, :, 34 : 46), 3);
Bank{2, 5} = sum(X(:, :, 48 : 54), 3);
Bank{2, 6} = sum(X(:, :, 56 : 68), 3);

yy = 1; 
clear Z;
for y = -50 : 50
    yy1 = 1;
    for y1 = -50 : 50
        A_1 = sum(X(:, :, 1 : 19), 3);
        A_1 = imrotate(A_1, 0, 'bilinear', 'crop');
        A_1 = imtranslate(A_1, [y y1]);
        Bank{1, 1} = A_1;
        
        A_2 = sum(X(:, :, 20 : 29), 3);
        A_2 = imrotate(A_2, -3, 'bilinear', 'crop');
        A_2 = imtranslate(A_2, [-13 0]);
        Bank{1, 2} = A_2;
        
        A_3 = sum(X(:, :, 30 : 33), 3);
        A_3 = imrotate(A_3, -3, 'bilinear', 'crop');
        A_3 = imtranslate(A_3, [10 0]);
        Bank{1, 3} = A_3;
        
        A_4 = sum(X(:, :, 34 : 46), 3);
        A_4 = imrotate(A_4, -4, 'bilinear', 'crop');
        A_4 = imtranslate(A_4, [10 -10]);
        Bank{1, 4} = A_4;
        
        A_5 = sum(X(:, :, 48 : 54), 3);
        A_5 = imrotate(A_5, -3, 'bilinear', 'crop');
        A_5 = imtranslate(A_5, [20 0]);
        Bank{1, 5} = A_5;
        
        A_6 = sum(X(:, :, 56 : 68), 3);
        A_6 = imrotate(A_6, -3, 'bilinear', 'crop');
        A_6 = imtranslate(A_6, [10 -10]);
        Bank{1, 6} = A_6;
        
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
plot(-log(Z))
legend
axis off

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

