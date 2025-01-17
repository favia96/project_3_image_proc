function [psnr_intra,bitrates]=intra_eval(frames,recon_frames,coeff,steps)
hist_intra=zeros(length(steps),length(frames),16,16,9,11);
for i=1:length(steps)
    for j=1:length(frames)
        psnr_intra(i,j)=my_mse(recon_frames{i,j},frames{j});
        %psnr_intra=my_psnr(psnr_intra);
        for index1=1:9
            for index2=1:11
                hist_intra(i,j,:,:,index1,index2)=coeff{i,j}{index1,index2};
            end
        end
    end
end
bitrates=zeros(length(steps),length(frames),16,16);
for i=1:length(steps)
    for j=1:length(frames)
        for blcok_index1=1:16
             for block_index2=1:16
                 prob=reshape(hist_intra(i,j,blcok_index1,block_index2,:,:,:),1,9*11);
                 prob=hist(prob,min(prob):steps(i):max(prob));
                 prob=prob./sum(prob);
                 bitrates(i,j,blcok_index1,block_index2)=-sum(prob.*log2(prob+eps));
             end
        end
    end
end
psnr_intra=sum(psnr_intra,2)/length(frames);
psnr_intra=my_psnr(psnr_intra);

bitrates=sum(bitrates,4);
bitrates=sum(bitrates,3);
%bitrates=bitrates./256;
bitrates=bitrates*9*11;
bitrates=sum(bitrates,2)/50;
bitrates=bitrates*30/1000;
end