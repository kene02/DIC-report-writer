% File name       : ssim_psnr_calculator.m
% Author(s)       : Ken Ely
% Institution     : Monash University
% Last modified   : 26 May 2026
% Licence         : All rights reserved
% 
% Description:
% Evaluates the PSNR and SSIM between multiple sets of DIC plots and a 
% reference dataset.

clear all; close all; clc;

% Magnitudes
magnitudes = 0:20:100;

% Angles
angles = 0:15:90;

% Reference dataset
ref = "input-data/clear-clear.mat";

values = [];
for m = magnitudes
    % file = sprintf("ohtcfrp_00_m%d_t0_vs_ohtcfrp_11_m%d_t0.mat", m, m);
    file = sprintf("input-data/ohtcfrp_00_vs_ohtcfrp_11_m%d_t0.mat", m);
    disp(file);
    new_row = [0, 0, m, 0, ssims(file, ref), psnrs(file, ref)];
    values = [values; new_row];
end

for t = angles
    file = sprintf("input-data/ohtcfrp_00_vs_ohtcfrp_11_m20_t%d.mat", t);
    disp(file);
    new_row = [0, 0, 20, t, ssims(file, ref), psnrs(file, ref)];
    values = [values; new_row];
end

% Export to CSV
headings = ["Ref_Motion_Blur_Magnitude", "Ref_Motion_Blur_Direction", ...
    "Current_Motion_Blur_Magnitude", "Current_Motion_Blur_Direction", ...
    "SSIM_u", "SSIM_v", "SSIM_exx", "SSIM_exy", "SSIM_eyy", ...
    "PSNR_u", "PSNR_v", "PSNR_exx", "PSNR_exy", "PSNR_eyy"
];
T = array2table(values, 'VariableNames', headings);
writetable(T, 'psnr-ssim-data.csv');