function [I] = translateImg(Im_in)
% Im_in - is a cell (element) from imgDS_probX_b4 (18x1 cell array)
%   <<316 316 45 68 | Pixel_row Pixel_col time_frame trial>>
shiftBank = zeros(size(Im_in, 4), 2); % trial x 2
time = 12;

for trial = 1 : size(Im_in, 4)
        HeatMap = Im_in(:, :, time, trial);
        HeatMap(~isnan(HeatMap)) = 1;
        HeatMap(isnan(HeatMap)) = 0;

   if nansum(nansum(HeatMap)) % if empty move on
        pixValue = 0; righShift = 0; 
        coordinate = 1;
        while pixValue == 0
            % horizontal shift
            pixValue = HeatMap(size(HeatMap, 1)/2, size(HeatMap, 2) - righShift);
            righShift = righShift + 1;
            shiftBank(trial, coordinate) = righShift;
        end
        
        pixValue = 0; bottomShift = 0;
        coordinate = 2;
        while pixValue == 0
            % vertical shift
            pixValue = HeatMap(size(HeatMap, 1) - bottomShift, size(HeatMap, 2)/2);
            bottomShift = bottomShift + 1;
            shiftBank(trial, coordinate) = bottomShift;
        end
   end
   trial
end

clear I
shiftIm = squeeze(Im_in(:, :, time, :));
shiftIm(isnan(shiftIm)) = 0;
for trial = 1 : size(shiftIm, 3)
    Map = shiftIm(:, :, trial);
    I(:, :, trial) = imtranslate(Map, [shiftBank(trial, :)]);
    trial
end
end
