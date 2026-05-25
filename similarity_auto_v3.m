% File name       : similarity_auto_v3.m
% Author(s)       : Ken Ely
% Institution     : Monash University
% Last modified   : 22 May 2026
% Licence         : All rights reserved
% 
% Description:
% Evaluates the PSNR and SSIM between two sets of DIC data.

clear all; close all; clc;

% Magnitudes
magnitudes = 0:20:100;

% Reference dataset
ref = "clear-clear.mat";

% Make a report folder (if one doesn't already exist)
if ~isfolder("report")
    mkdir("report");
end

% Make a dic-plots folder (if one doesn't already exist)
if ~isfolder("report/dic-plots")
    mkdir("report/dic-plots");
end

% Open tex file
fid = fopen('report/report.tex', 'w');

% Write start of document
str = ["\\documentclass[a4paper, twoside]{article}";
    "\\usepackage[left=1in, top=1in, bottom=1in, right=1in]{geometry}";
    "\\usepackage{graphicx}";
    "\\usepackage{siunitx}";
    "\\usepackage{subcaption}";
    "\\title{DIC Report}";
    "\\author{Ken Ely}";
    "\\date{May 2026}\n";
    "\\begin{document}\n\n";
    "\\maketitle\n\n"
];
fprintf(fid, strjoin(str, newline));

% Add section for each blurry dataset
for m = magnitudes
    file = sprintf("input-data/ohtcfrp_00_m%d_t0_vs_ohtcfrp_11_m%d_t0.mat", m, m);
    fprintf("Evaluating results for "+file+" ...\n")
    fprintf(fid, "\\section{Motion blur of $"+m+"\\angle\\ang{0}$}\n");
    results = result_eval(file, ref, file, "report/dic-plots/");
    fprintf(fid, results);
end

fprintf(fid, "\\end{document}");

% Close tex file
fclose(fid);