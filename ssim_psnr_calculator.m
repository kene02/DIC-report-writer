% File name       : ssim_psnr_calculator.m
% Author(s)       : Ken Ely
% Institution     : Monash University
% Last modified   : 25 May 2026
% Licence         : All rights reserved
% 
% Description:
% Evaluates the PSNR and SSIM between multiple sets of DIC plots and a 
% reference dataset.

clear all; close all; clc;

% Magnitudes
magnitudes = 0:20:100;

% Reference dataset
ref = "clear-clear.mat";

values = [];
for m = magnitudes
    file = sprintf("ohtcfrp_00_m%d_t0_vs_ohtcfrp_11_m%d_t0.mat", m, m);
    disp(file);
    new_row = [m, 0, ssims(file, ref), psnrs(file, ref)];
    values = [values; new_row];
end

% Export to CSV
headings = ["Motion_Blur_Magnitude", "Motion_Blur_Direction", ...
    "SSIM_u", "SSIM_v", "SSIM_exx", "SSIM_exy", "SSIM_eyy", ...
    "PSNR_u", "PSNR_v", "PSNR_exx", "PSNR_exy", "PSNR_eyy"
];
T = array2table(values, 'VariableNames', headings);
writetable(T, 'psnr-ssim-data.csv');