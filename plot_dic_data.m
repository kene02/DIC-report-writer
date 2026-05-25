function plot_dic_data(dic_data, bounds)
%PLOT_DIC_DATA Visualise DIC data with masking and colour scaling.
%
%   PLOT_DIC_DATA(DIC_DATA, BOUNDS) displays a 2D Digital Image
%   Correlation (DIC) dataset using a colour-scaled image.
%
%   Zero-valued elements in DIC_DATA are treated as invalid data and are
%   hidden using transparency masking.
%
%   BOUNDS specifies the colour axis limits as:
%
%       [LOWER_BOUND, UPPER_BOUND]
%
%   The figure is created off-screen and the aspect ratio is preserved so
%   that image pixels are displayed as squares.
%
%   Example
%   -------
%       bounds = [-0.01, 0.01];
%       plot_dic_data(dic_data, bounds);
arguments (Input)
    dic_data
    bounds (1,2) double
end

figure('Visible', 'off');
imagesc(dic_data, 'AlphaData', dic_data ~= 0, bounds);
colorbar;
% Keep the original aspect ratio (pixels are squares)
axis image; 

end