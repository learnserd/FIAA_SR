% Demonstration script for 3D seismic reconstruction via Fast Iterative Adaptive Approach 
% Corresponding paper:Fast Iterative Adaptive Approach for 3D Seismic Data Reconstruction
% Decription: This demo tests FIAA on a small data without windowing technique.
% Author: ZhiGang Dai
% Email:  daizg@cug.edu.cn
% Date: May, 8, 2018
%
clc;
clear;
close all;

load 'prestack_shot9.mat';                %load data
seis_x=Data(1:64,1:40,1:40);                                                    
seis_origin=(seis_x-min(seis_x(:)))/(max(seis_x(:)-min(seis_x(:))));   %normalization
[nt,nx,ny]=size(seis_origin);
m=0.5;                                    %missing rate            
iter=10;                                   %Iteration number
 m=round(nx*ny*m);
 L1=sort(randsample(nx*ny,m),'ascend'); 
 seis_sam=seis_origin;
 seis_sam(:,L1)=0;
 se_fft=fft(seis_sam);              %transform data into frequency domain
L2=find(seis_sam(1,:,:)~=0);        %Index of available data
Index=get_Index(nx,ny);             %Index is used in get_E.m script
Df=ones(nx,ny,nt);                                                                              
K=80;                     %frequency grids: Kx=Ky=80
tic
for i=1:nt/2+1;                                                                                           
i
    Df_m_i=permute(se_fft(i,:,:),[2 3  1]);                                    
     Df(:,:,i)=FIAA(Df_m_i,Index,nx,ny,L2,K,iter);                                 
end
toc
MR=zeros(nt,nx,ny);
  MR(1:nt/2+1,:,:)=permute(Df(:,:,1:nt/2+1),[3,1,2]);
MR(nt/2+2:nt,:,:)=conj(flipud(MR(2:nt/2,:,:)));
 Dt=real(ifft(MR));                             %transform the data back to time domain
 snr= SNR1(seis_origin(:),Dt(:))             %compute SNR
 Threedimension(seis_origin,2,3,1,1);           %plot data
Threedimension(seis_sam,2,3,1,2);
    
Threedimension(Dt,2,3,1,3);
Threedimension(abs(seis_origin-Dt),2,3,1,4);
