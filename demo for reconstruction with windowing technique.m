% Demonstration script for 3D seismic reconstruction via Fast Iterative Adaptive Approach 
% Corresponding paper:Fast Iterative Adaptive Approach for 3D Seismic Data Reconstruction
%Description: This script uses windowing technique to make the guarantee the linear events assumption. 
% Author: ZhiGang Dai
% Email:  daizg@cug.edu.cn
% Date: May, 8, 2018
%
clc;
clear;
close all;

load 'prestack_shot9.mat';               %load data
seis_x=Data(1:64,1:120,1:120);
block_size=24;                        %window size
block_num=5;                          %window number
seis_origin=(seis_x-min(seis_x(:)))/(max(seis_x(:)-min(seis_x(:))));  %normalization
[nt,nx,ny]=size(seis_origin);
m=0.5;             %missing rate            
iter=10;             %Iteration number
 m=round(nx*ny*m);
 L1=sort(randsample(nx*ny,m),'ascend'); %index set of missing data
 seis_sam=seis_origin;
 seis_sam(:,L1)=0;         %observed data with randomly missing traces
 Ls=ones(nx,ny);         
 Ls(L1)=0;
 Lss=mat2cell(Ls,ones(block_num,1)*block_size,ones(block_num,1)*block_size);
 for i=1:block_num^2
    H{i}=find(Lss{i}~=0); %H{i} denotes the index set of avalible data correponding to the ith block  
 end
 se_fft=fft(seis_sam);          %transform data into frequency domain                                                                      %Index of available data

Index=get_Index(block_size,block_size);   %Index is used in get_E.m script
Df=ones(nx,ny,nt);    
Ds=ones(block_size,block_size*block_num);  
K=80;                    %frequency grids: Kx=Ky=80
tic
for i=1:nt/2+1;                                                                                           
i
 zz = mat2cell(permute(se_fft(i,:,:),[2,3,1]), ones(block_num,1)*block_size, ones(block_num,1)*block_size) ; % blocking
for j=1:block_num^2
%      s=IAA_2_1D(zz{j},Index,32,32,H{j},K,iter);
                             
     s=FIAA(zz{j},Index,block_size,block_size,H{j},K,iter);  
     Ds(:,(j-1)*block_size+1:j*block_size)=s;  
end
Ds2=mat2cell(Ds,block_size,ones(block_num^2,1)*block_size);
 Df(:,:,i)=cell2mat(reshape(Ds2,[block_num,block_num]));
 fprintf('%d slice completed\n',i);
end
toc

MR=zeros(nt,nx,ny);
  MR(1:nt/2+1,:,:)=permute(Df(:,:,1:nt/2+1),[3,1,2]);
MR(nt/2+2:nt,:,:)=conj(flipud(MR(2:nt/2,:,:)));
 Dt=real(ifft(MR));                      %transform the data back to time domain
 snr= SNR1(seis_origin(:),Dt(:))         %compute SNR
 Threedimension(seis_origin,2,3,1,1);      %plot data 
Threedimension(seis_sam,2,3,1,2);

Threedimension(Dt,2,3,1,3);
Threedimension(abs(seis_origin-Dt),2,3,1,4);
