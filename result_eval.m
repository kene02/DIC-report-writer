function out_str = result_eval(blurry_path, clear_path, out_name, out_path)
%RESULT_EVAL Generate LaTeX summary and evaluate image quality metrics
%   Compares displacement and strain fields from a blurry and a reference
%   (clear) dataset. The function computes SSIM and PSNR for each field
%   ($u$, $v$, $e_{xx}$, $e_{xy}$, $e_{yy}$), generates corresponding plots,
%   and exports them as image files.
%
%   It returns a LaTeX-formatted string containing:
%     - \includegraphics commands for the exported plots
%     - A table summarising SSIM and PSNR values
%
%   Inputs:
%     blurry_path - Path to .mat file containing blurred data (data_dic_save)
%     clear_path  - Path to .mat file containing reference data
%     out_name    - Base filename for exported images
%     out_path    - Output directory for images (optional)
%
%   Output:
%     out_str     - LaTeX code block for embedding figures and results table
arguments (Input)
    blurry_path string
    clear_path string
    out_name string
    out_path string = ""
end

arguments (Output)
    out_str string
end

% File name       : result_eval.m
% Author(s)       : Ken Ely
% Institution     : Monash University
% Last modified   : 25 May 2026
% Licence         : All rights reserved
%
% Description:
% Evaluates the PSNR and SSIM between two sets of DIC data and generates
% LaTeX-formatted output including plots and a results table.

% Write LaTeX code for including plots
out_str = "\\begin{minipage}{\\textwidth}\n";
graphics_str = "\\includegraphics[height=160pt]{dic-plots/"+erase(out_name, ".mat");
out_str = out_str + graphics_str+"_u.png}\n";
out_str = out_str + graphics_str+"_v.png}\n";
out_str = out_str + graphics_str+"_exx.png}\n";
out_str = out_str + graphics_str+"_exy.png}\n";
out_str = out_str + graphics_str+"_eyy.png}\n\n";
out_str = out_str + "\\vspace{12pt}\n\n";

% Create table
out_str = out_str + ...
    "\\centering\n" + ...
    "\\begin{tabular}{|l|S[table-format=1.4]|S|}\n" + ...
    "\\hline\n" + ...
    "\\textbf{Plot} & {\\textbf{SSIM}} & {\\textbf{PSNR} (dB)} \\\\ \\hline\n";

% Load clear data
load(clear_path)
clear_data = data_dic_save;

% Load blurry data
load(blurry_path)
blurry_data = data_dic_save;

%% u displacement
% Evaluate SSIM and PSNR put them into the table
plot_title = "u displacement";
A = blurry_data.displacements.plot_u_ref_formatted;
ref = clear_data.displacements.plot_u_ref_formatted;
out_str = out_str + ...
    sprintf("$u$ displacement & %.4f & %.4f", ssim(A,ref), psnr(A,ref)) + ...
    " \\\\\n";

% Export each plot as a PNG file
plot_dic_data(A);
title(plot_title)
exportgraphics(gcf, out_path+erase(out_name, ".mat")+"_u.png");
fprintf(out_path+erase(out_name, ".mat")+"_u.png exported.\n")

%% v displacement
% Evaluate SSIM and PSNR put them into the table
plot_title = "v displacement";
A = blurry_data.displacements.plot_v_ref_formatted;
ref = clear_data.displacements.plot_v_ref_formatted;
out_str = out_str + ...
    sprintf("$v$ displacement & %.4f & %.4f", ssim(A,ref), psnr(A,ref)) + ...
    " \\\\\n";

% Export each plot as a PNG file
plot_dic_data(A);
title(plot_title)
exportgraphics(gcf, out_path+erase(out_name, ".mat")+"_v.png");
fprintf(out_path+erase(out_name, ".mat")+"_v.png exported.\n")

%% exx strain
% Evaluate SSIM and PSNR put them into the table
plot_title = "exx strain";
A = blurry_data.strains.plot_exx_ref_formatted;
ref = clear_data.strains.plot_exx_ref_formatted;
out_str = out_str + ...
    sprintf("$e_{xx}$ strain & %.4f & %.4f", ssim(A,ref), psnr(A,ref)) + ...
    " \\\\\n";

% Export each plot as a PNG file
plot_dic_data(A);
title(plot_title)
exportgraphics(gcf, out_path+erase(out_name, ".mat")+"_exx.png");
fprintf(out_path+erase(out_name, ".mat")+"_exx.png exported.\n")

%% exy strain
% Evaluate SSIM and PSNR put them into the table
plot_title = "exy strain";
A = blurry_data.strains.plot_exy_ref_formatted;
ref = clear_data.strains.plot_exy_ref_formatted;
out_str = out_str + ...
    sprintf("$e_{xy}$ strain & %.4f & %.4f", ssim(A,ref), psnr(A,ref)) + ...
    " \\\\\n";

% Export each plot as a PNG file
plot_dic_data(A);
title(plot_title)
exportgraphics(gcf, out_path+erase(out_name, ".mat")+"_exy.png");
fprintf(out_path+erase(out_name, ".mat")+"_exy.png exported.\n")

%% eyy strain
% Evaluate SSIM and PSNR put them into the table
plot_title = "eyy strain";
A = blurry_data.strains.plot_eyy_ref_formatted;
ref = clear_data.strains.plot_eyy_ref_formatted;
out_str = out_str + ...
    sprintf("$e_{yy}$ strain & %.4f & %.4f", ssim(A,ref), psnr(A,ref)) + ...
    " \\\\ ";

% Export each plot as a PNG file
plot_dic_data(A);
title(plot_title)
exportgraphics(gcf, out_path+erase(out_name, ".mat")+"_eyy.png");
fprintf(out_path+erase(out_name, ".mat")+"_eyy.png exported.\n")

% End table and minipage
out_str = out_str + "\\hline\n\\end{tabular}\n\\end{minipage}\n\n";

end