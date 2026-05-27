function psnr_values = psnrs(blurry_path, clear_path)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
arguments (Input)
    blurry_path string
    clear_path string
end

arguments (Output)
    psnr_values
end

% Load clear data
load(clear_path)
clear_data = data_dic_save;

% Load blurry data
load(blurry_path)
blurry_data = data_dic_save;

psnr_values = zeros(1, 5);

% Evaluate SSIM and PSNR for each plot and put them into the table
% u displacement
A = blurry_data.displacements.plot_u_ref_formatted;
ref = clear_data.displacements.plot_u_ref_formatted;
psnr_values(1) = psnr(A, ref);

% v displacement
A = blurry_data.displacements.plot_v_ref_formatted;
ref = clear_data.displacements.plot_v_ref_formatted;
psnr_values(2) = psnr(A, ref);

% exx strain
A = blurry_data.strains.plot_exx_ref_formatted;
ref = clear_data.strains.plot_exx_ref_formatted;
A = (A + 2E-3)*256 / 4E-3;
ref = (ref + 2E-3)*256 / 4E-3;
psnr_values(3) = psnr(A, ref);

% exy strain
A = blurry_data.strains.plot_exy_ref_formatted;
ref = clear_data.strains.plot_exy_ref_formatted;
psnr_values(4) = psnr(A, ref);

% eyy strain
A = blurry_data.strains.plot_eyy_ref_formatted;
ref = clear_data.strains.plot_eyy_ref_formatted;
A = (A * 256) / 10E-3;
ref = (ref * 256) / 10E-3;
psnr_values(5) = psnr(A, ref);

end