%% Clear and addpath
clear; clc;
addpath(genpath('E:\KTH\P2\Image Processing\Project3'))
%% Uniform Quantizer
uniform_quantizer = @(x,ssize) round(x/ssize)*ssize;
%% Intra-frame coding
frame_size=[176,144];
frames=yuv_import_y('foreman_qcif.yuv',frame_size,50);
%imagesc(video1{1})
steps=[2^3,2^4,2^5,2^6];
[recon_frames,enc_dct16]=intra_coding(frames,steps,frame_size);
[psnr_intra1,bitrates]=intra_eval(frames,recon_frames,enc_dct16_quan,steps);




