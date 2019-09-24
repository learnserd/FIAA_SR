
% FIAA for 3-D seismic data reconstruction with randomly missing traces
% Author: ZhiGang Dai
% Email:  daizg@cug.edu.cn
% Date: May, 8, 2018

function M_s=IAA_2_1D(Y,Index,nx,ny,L2,K,iter)
Yg=Y(:);
y=Yg(L2);
B=fft2(Y,K,K);
Rinv_y=zeros(nx*ny,1);
Rs=zeros(nx*ny);
for i=1:iter
P=abs(B).^2;
    R=getm_R(P,nx,ny,K,K);
    Rg=R(L2,L2);
Rinv_y(L2)=Rg\y; 
  C=fft2(reshape(Rinv_y,[nx ny]),K,K);
Rs(L2,L2)=inv(Rg);
E=get_1_E(Rs,Index,nx,ny,K);
    D=K^2*ifft2(E);
    B=C./D; 
end
clearvars B C D E P Rs Rg Index;
Ym=R*Rinv_y;
Ym(L2)=0;
 Y_r=Yg+Ym;
M_s=reshape(Y_r,nx,ny);

end