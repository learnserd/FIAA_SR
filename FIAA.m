% Fast iterative adaptive apprach script written by  DZG
% FIAA for 3-D seismic data reconstruction with randomly missing traces
% Author: ZhiGang Dai
% Email:  daizg@cug.edu.cn
% Date: May, 8, 2018

function d_r=FIAA(D,Index,nx,ny,L2,K,iter)
dg=D(:);
d=dg(L2);
U=fft2(D,K,K);                                                                     %Intialization for FIAA
Rinv_y=zeros(nx*ny,1);
Rs=zeros(nx*ny);
for i=1:iter
P=abs(U).^2;                                                                      %update power spectral matrix
    R=compute_R(P,nx,ny,K,K);                                                  %compute the covariance matrix R
    Rg=R(L2,L2);                                                                    % compute the covariance matrix Rg       
Rinv_y(L2)=Rg\d;                                                           
  Fai_D=fft2(reshape(Rinv_y,[nx ny]),K,K);                                    %compute numerator part of U=Fai_D./Fai_N
Rs(L2,L2)=inv(Rg);
W=compute_coff(Rs,Index,nx,ny,K);                                                    %compute coefficient matrix W
    Fai_N=K^2*ifft2(W);                                                                         %compute denominator part of U=Fai_D./Fai_N
    U=Fai_D./Fai_N;                                                                                  %update amplitude spectral matrix
end 
dm=R*Rinv_y;
dm(L2)=0;
 d_r=dg+dm;                                      
d_r=reshape(d_r,nx,ny);                                                              %M_s :reconstructed frequency slice  

end