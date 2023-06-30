t_mov = 40;
Img_fix = imgaussfilt(Img(50:250, 120:250, 16, 5), 4);
Img_mov = imgaussfilt(Img(50:250, 120:250, 16, t_mov), 4);
Img_mov(isnan(Img_mov)) = 0;
Img_mov_t = Img(:, :, 16, t_mov);
Img_mov_t = imrotate(Img_mov_t, -4);
% if sum(size(Img_mov_t)) ~= 632
%     d = size(Img_mov_t, 1) -  size(Img, 1);
%     Img_mov_t = Img_mov_t(d/2 : size(Img_mov_t, 1) - (d/2  + 1),...
%     d/2 : size(Img_mov_t, 1) - (d/2  + 1));
% end
Img_mov_t = imgaussfilt(Img_mov_t(50:250, 120:250), 4);

Img_mov_tfull = Img(:, :, 16, 40);
Img_mov_tfull = imrotate(Img_mov_tfull, -5);
Img_mov_tfull = Img_mov_tfull(17 : 348 - 16, 17 : 348 - 16);

figure
subplot(3, 1, 1)
Img_Full =Img(:, :, 16, 5);
imagesc(Img_Full)
title('Fixed Image')
set(gca, 'FontSize', 15)
axis off

subplot(3, 1, 2)
Img_movFull = Img(:, :, 16, 40);
imagesc(Img_movFull)
title('Moving Image')
set(gca, 'FontSize', 15)
axis off

subplot(3, 1, 3)
imagesc(Img_mov_tfull)
title('Moved Image')
set(gca, 'FontSize', 15)
axis off

figure, 
subplot(3, 1, 1)
imagesc(Img_fix)
title('Focused fixed image')
set(gca, 'FontSize', 15)
axis off

subplot(3, 1, 2)
imagesc(Img_mov)
title('Focused moving image')
set(gca, 'FontSize', 15)
axis off

subplot(3, 1, 3)
imagesc(Img_mov_t)
title('Focused moved image')
set(gca, 'FontSize', 15)
axis off

Img_fix(isnan(Img_fix)) = 0; Img_mov_t(isnan(Img_mov_t)) = 0;

figure, 
subplot(2, 1, 1)
scatter(Img_fix, Img_mov_t)
m = fitlm(Img_fix(:), Img_mov_t(:));
xlabel('Fixed Image') 
ylabel('Moving Image')
title('Moving vs Fixed correlation: ', num2str(sqrt(m.Rsquared.Ordinary)))
set(gca, 'FontSize', 15)
axis off

subplot(2, 1, 2)
scatter(Img_fix, Img_mov)
m1 = fitlm(Img_fix(:), Img_mov(:));
title(sqrt(m1.Rsquared.Ordinary))
xlabel('Fixed Image') 
ylabel('Moved Image')
title('Moved vs Fixed correlation: ', num2str(sqrt(m1.Rsquared.Ordinary)))
set(gca, 'FontSize', 15)
axis off

