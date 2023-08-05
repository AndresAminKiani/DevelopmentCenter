function [Z] = fminAL3sub(X, xv)
    col = 120 : 300;
    row = 40 : 300;
    
    Group_1 = sum(X(row, col, 1 : 19), 3);
    Group_1 = imrotate(Group_1, xv(13), 'bilinear', 'crop');
    Groups{1, 1} = imtranslate(Group_1, [xv(1) xv(2)]);

    Group_2 = sum(X(row, col, 20 : 29), 3);
    Group_2 = imrotate(Group_2, xv(14), 'bilinear', 'crop');
    Groups{1, 2} = imtranslate(Group_2, [xv(3) xv(4)]);

    Group_3 = sum(X(row, col, 30 : 33), 3);
    Group_3 = imrotate(Group_3, xv(15), 'bilinear', 'crop');
    Groups{1, 3} = imtranslate(Group_3, [xv(5) xv(6)]);

    Group_4 = sum(X(row, col, 34 : 46), 3);
    Group_4 = imrotate(Group_4, xv(16), 'bilinear', 'crop');
    Groups{1, 4} = imtranslate(Group_4, [xv(7) xv(8)]);

    Group_5 = sum(X(row, col, 48 : 54), 3);
    Group_5 = imrotate(Group_5, xv(17), 'bilinear', 'crop');
    Groups{1, 5} = imtranslate(Group_5, [xv(9) xv(10)]);

    Group_6 = sum(X(row, col, 56 : 68), 3);
    Group_6 = imrotate(Group_6, xv(18), 'bilinear', 'crop');
    Groups{1, 6} = imtranslate(Group_6, [xv(11) xv(12)]);

k = 1;
for z = 1 : 6
    for j = 1 : 6
        if z ~= j
            Z_corr( k ) = corr2( imgaussfilt(Groups{1, z}, 3), imgaussfilt(Groups{1, j}, 3) );
            k = k + 1;
        end
    end
end

Z = -log(mean(Z_corr));
end
