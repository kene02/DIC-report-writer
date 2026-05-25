function plot_dic_data(dic_data)
%PLOT_DIC_DATA Visualises DIC data with outlier clipping and masking.
%   This function displays a 2D Digital Image Correlation (DIC) dataset 
%   using a colour-scaled image. The colour limits are set based on a 
%   ±2 standard deviation range from the mean to reduce the influence of 
%   outliers and improve visual contrast. Zero-valued elements are treated 
%   as invalid data and are hidden using transparency. The resulting figure 
%   is generated off-screen and preserves the original aspect ratio so that 
%   pixels are displayed as squares.
arguments (Input)
    dic_data
end

% Calculate mean and standard deviation
mu = mean(dic_data(dic_data ~= 0), 'all');
sigma = std(dic_data(dic_data ~= 0), [], 'all');

% Define 3-sigma bounds
lower_bound = mu - sigma;
upper_bound = mu + sigma;

figure('Visible', 'off');
imagesc(dic_data, 'AlphaData', dic_data ~= 0, [lower_bound upper_bound]);
colorbar;
% Keep the original aspect ratio (pixels are squares)
axis image; 

end