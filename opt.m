clear A
element = 1; k = 1;
Img = imgDS_prob1_b4{ element };
trial = 1; time = 16; row = 50 : 250; col = 120 : 270;
Img_Fixed = Img(row, col, time, trial);
Img_Fixed(isnan(Img_Fixed)) = 0;
Img_Fixed = imgaussfilt(Img_Fixed, 4);
for trial = 1 : size(Img, 4)
        for r = 1 - min(row) : 316 - max(row)
            for c = 1 - min(col) : 316 - max(col)
                for rot = -20 : 20
                    F = imrotate(Img_Fixed, rot, 'bilinear', 'crop');
                    M = fitlm(F(:), Img_Fixed(:));
                    x = sqrt(M.Rsquared.Ordinary);
                    A(k, :) = [trial, r, c, rot, x];
                    k = k + 1;
                end
                c
            end
            r
        end
        trial
end
